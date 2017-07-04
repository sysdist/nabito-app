class Relay < ApplicationRecord
  belongs_to :el_socket
  
   
  ON = 1
  OFF = 0

  def switch_on
    #puts "system sudo relay #{id} #{pin_id} #{pin_num} #{ON}"
    puts "IN RELAY MODEL: system sudo relay #{pin_num} #{ON}" #run a bash script, turn GPIO pin on
    system "relay #{pin_num} #{ON}"
  end
  
  def switch_off
    puts "system sudo relay #{pin_num} #{OFF}"
    system "relay #{pin_num} #{OFF}"
  end
end
