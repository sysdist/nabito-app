desc "Starting background process for socket monitoring"
task :monitor => :environment do
    
  ser = SerialPort.new("/dev/ttyUSB0", 9600, 8, 1, SerialPort::NONE)
  ser.readline #two empty reads to sync with the serial port and not read false values 
  ser.readline
  
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
  
  def log_power(monitor, serial_port)
    
    t = Time.now
    tnext = t + monitor.frequency
    c = 0
    p_total = 0.0
    p_avg = 0.0
    while Time.now < tnext
      line = serial_port.readline
      arr = line.split(';')     #read all inputs at once as a line and split them by ";" into an array
      
      irms = arr[monitor.current_sensor_id].to_f   
      irms = 0.0 if irms < 0.1  #if current lower than 0.1A set to 0 because of the ADC flapping at low values
      i_rounded = irms.to_f.round(3)
      
      p_rounded = 0.0
      vrms = monitor.nominal_voltage
      if (monitor.voltage_sensor_id)
        vrms = arr[monitor.current_sensor].to_f
      end
      prms = irms * vrms 
      p_total +=  prms
      c += 1
    end
    p_avg = p_total / c
    p_rounded = (p_avg).round(3)
    
    puts "#{Time.now}: Monitor #{monitor.id}; Socket: #{monitor.el_socket_id}; Power: #{p_rounded}"
    SocketLoad.create!(el_socket_id: monitor.el_socket_id, i_current: i_rounded, voltage: vrms, power: p_rounded, time: Time.now)
  end
   
  while true
    mon = SocketMonitor.first
    if mon.active
      log_power(mon,ser) 
    else
      puts "Monitoring not enabled. Exiting.."
      exit
    end
  end
  
 

  
end

#TODO:not used atm
# task :MW do
  # f = Rails.root.join('public/maintenance.html').to_s
  # bak = f + ".bak"
#   
  # if File.exist?(f) 
    # puts "Setting up MW"
    # File.rename(f, bak)
  # elsif File.exist?(bak) 
    # puts "Disabling MW"
    # File.rename(bak, f)
  # end 
# end
# 
# task :clear_master_data => :environment do
  # [ ElSocket, Relay, SocketMonitor ].each do |m|
    # puts "Truncating table #{m.table_name}"
    # ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{m.table_name} RESTART IDENTITY CASCADE;")
    # puts "Table #{m.table_name} truncated."
  # end
# end
# 
# task :clear_user_data => :environment do
  # [ User, SocketLoad, SocketUsage  ].each do |m|
    # puts "Truncating table #{m.table_name}"
    # ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{m.table_name} RESTART IDENTITY CASCADE;")
    # puts "Table #{m.table_name} truncated."
  # end
# end


# task :assign_currencies => :environment do
  # Country.all.each do |c|
    # puts "coutry: #{c.code} curr: #{c.currency_code}"
    # ccode = c.currency_code
    # curr = Currency.find_by_code(ccode)
      # #c.update_column(:currency_id, nil)
    # if curr
     # puts "Curr: #{curr.code} rate: #{curr.rate}"
      # c.update_column(:currency_id, curr.id)
    # end
  # end
# end

