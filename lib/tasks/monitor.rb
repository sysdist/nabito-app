require 'pg'
require 'serialport'
  
  def pg_connect
    conn = PGconn.connect(host: 'localhost', port: 5432, user: 'nabito', password: 'changeme', dbname:  'nabito_development')
    return conn
  end
  
  def serial_init
    port = SerialPort.new("/dev/ttyUSB0", 9600, 8, 1, SerialPort::NONE)
    port.readline #two empty reads to sync with the serial port and not read false values 
    port.readline
    return port
  end
  
  #fake serial port class for testing purposes
  class FakeSerial
    
    def readline
      num = rand.round(3)
      return "#{num};0;0;0;0;0" #because Arduino has 6 ADCs
    end
  end
  
  def shut_down
    puts "\nShutting down monitoring..."
    sleep 1
  end
   
  # Trap ^C 
  Signal.trap("INT") { 
    shut_down 
    exit
  }
  
  # Trap `Kill `
  Signal.trap("TERM") {
    shut_down
    exit
  }
  
  
  def create_socket_load(el_socket_id, i_current, voltage, power, time)
    conn = pg_connect()
    conn.prepare('statement1', 'insert into socket_loads (el_socket_id, i_current, voltage, power, time, created_at, updated_at) values ($1, $2, $3, $4, $5, $6, $7)')
    conn.exec_prepared('statement1', [ el_socket_id, i_current, voltage, power, time, time, time ])
    conn.close
  end
  
  def get_monitors
    conn = pg_connect()
    res = conn.exec("select * from socket_monitors;")
    return res
  end
  
  # => logs V,I and P into table socket_loads
  # => reads from USB serial input as long as is defined in the monitor frequency, then calculates averages and writes the record into the table
  # => TODO: for single monitor, this logic is fine, but if there were more, a different concept is needed, prolly some sort of Queuing Manager,
  # =>       because sockets may be logged at different frequencies (eg socket1 is every 5s, socket2 is every 60s)
  def log_power(monitor, serial_port)
    t = Time.now
    tnext = t + monitor['frequency'].to_f
    c = 0
    p_total = 0.0
    p_avg = 0.0
    i_total = 0.0
    i_avg = 0.0
    while Time.now < tnext
      line = serial_port.readline
      arr = line.split(';')     #read all inputs at once as a line and split them by ";" into an array
      irms = arr[monitor['current_sensor_id'].to_i].to_f   
      irms = 0.0 if irms < 0.1  #if current lower than 0.1A set to 0 because of the ADC flapping at low values
      p_rounded = 0.0
      vrms = monitor['nominal_voltage'].to_f
      if (monitor['voltage_sensor_id'])
        vrms = arr[monitor['voltage_sensor_id']].to_f
      end
      prms = irms * vrms 
      p_total +=  prms
      i_total += irms
      c += 1
    end
    p_avg = p_total / c
    i_avg = i_total / c
    p_rounded = (p_avg).round(3)
    i_rounded = i_avg.round(3)
    
    puts "#{Time.now}: I: #{i_rounded} Power: #{p_rounded}"
    create_socket_load(monitor['el_socket_id'].to_i, i_rounded, vrms, p_rounded, Time.now)
  end
    
  
  #main loop
  port = serial_init()
  
  #fake serial port for testing purposes
  #port = FakeSerial.new
  
  while true
    monitor = get_monitors.first #so far working with only one socket monitor, but later there can be more
    if monitor['active'] == "t" then #if monitoring enabled t = true
      log_power(monitor,port) 
    else
      puts "Monitoring not enabled. Exiting.."
      exit
    end
  end
    
    
