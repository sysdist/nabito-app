class SocketUsage < ApplicationRecord
  belongs_to :user
  belongs_to :el_socket


  def get_loads
    socket_loads = SocketLoad.where(time: start_time .. end_time)
    loads = {}
    socket_loads.each do |s|
      loads[s.time] = s.power
    end
    return loads
  end
  
  
end
