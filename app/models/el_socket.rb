class ElSocket < ApplicationRecord
  belongs_to :user
  has_one :relay
  has_one :socket_monitor

  def switch_on(active_user)
    puts "IN MODEL: socket #{id} is switched on"
    update(in_use: true, current_user: active_user.id)
    relay.switch_on
    socket_usage = SocketUsage.create!(user: active_user,
                                       el_socket: self, start_time: Time.now,
                                       date: Date.today)
                                       
    active_user.last_usage = socket_usage.id
    active_user.save
    
    start_monitoring  #start monitoring background job                                       
  end
  
  def switch_off(active_user)
    relay.switch_off
    socket_usage = SocketUsage.find(active_user.last_usage)
    
    
    socket_usage.end_time = Time.now
    socket_loads = SocketLoad.where(time: socket_usage.start_time .. socket_usage.end_time)
    total_watts = 0.0
    socket_loads.each do |e| 
      total_watts += e.power    
    end
    
    duration = socket_usage.end_time - socket_usage.start_time
    freq = 3600 / socket_monitor.frequency
    
    kWh = total_watts * duration / freq / 1000 / 3600
    
    socket_usage.kWhs = kWh
    socket_usage.amount = kWh * self.price_per_kWh
    socket_usage.save
    
    active_user.last_usage = nil
    active_user.save
    update(in_use: false, current_user: nil)
    
    stop_monitoring    
    
  end
  
  def available?
    return !in_use
  end
  
private
      def start_monitoring
        system "ruby #{Rails.root}/lib/tasks/monitor.rb &"
      end
      
      def stop_monitoring
        system "kill `ps -ef | grep \"monitor.rb\" | grep -v grep | awk '{print $2}'`"
      end

end
