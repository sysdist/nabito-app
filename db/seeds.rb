user = CreateUserService.new.admin
puts 'CREATED ADMIN USER: ' << user.email
CreateUserService.new.users
puts "created sample users"

ElSocket.create!([
  {user_id: 1, code: "S1", url: "", address: "", gps_lat: nil, gps_lng: nil, voltage: 230, i_limit: 16, price_per_kWh: 0.3, in_use: false, current_user: nil}
])
Relay.create!([
  {el_socket_id: 1, name: "Relay_1", pin_num: 11, pin_id: "PA1", is_on: false}
])
SocketMonitor.create!([
  {el_socket_id: 1, current_sensor_id: 0, voltage_sensor_id: nil, nominal_voltage: 230, active: true, frequency: 5}
])

SocketUsage.create!([
  {user_id: 1, el_socket_id: 1, start_time: "2017-06-02 12:04:03", end_time: "2017-06-02 12:42:20", kWhs: 0.0263776379361082, amount: 0.00791329138083245, date: "2017-06-02"}
 ])

SocketLoad.create!([
  {el_socket_id: 1, i_current: 0.0, voltage: 230.0, power: 0.139, time: "2017-06-02 12:05:23"},
  {el_socket_id: 1, i_current: 0.34, voltage: 230.0, power: 16.672, time: "2017-06-02 12:06:23"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 74.185, time: "2017-06-02 12:07:23"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 72.582, time: "2017-06-02 12:08:24"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 71.523, time: "2017-06-02 12:09:24"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 72.22, time: "2017-06-02 12:10:24"},
  {el_socket_id: 1, i_current: 0.31, voltage: 230.0, power: 71.76, time: "2017-06-02 12:11:24"},
  {el_socket_id: 1, i_current: 0.31, voltage: 230.0, power: 71.858, time: "2017-06-02 12:12:25"},
  {el_socket_id: 1, i_current: 0.31, voltage: 230.0, power: 71.453, time: "2017-06-02 12:13:25"},
  {el_socket_id: 1, i_current: 0.31, voltage: 230.0, power: 72.304, time: "2017-06-02 12:14:25"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 73.126, time: "2017-06-02 12:15:25"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 72.931, time: "2017-06-02 12:16:26"},
  {el_socket_id: 1, i_current: 0.31, voltage: 230.0, power: 72.29, time: "2017-06-02 12:17:26"},
  {el_socket_id: 1, i_current: 0.31, voltage: 230.0, power: 72.847, time: "2017-06-02 12:18:26"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 72.736, time: "2017-06-02 12:19:26"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 73.321, time: "2017-06-02 12:20:27"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 73.196, time: "2017-06-02 12:21:27"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 71.76, time: "2017-06-02 12:22:27"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 72.178, time: "2017-06-02 12:23:27"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 73.795, time: "2017-06-02 12:24:28"},
  {el_socket_id: 1, i_current: 0.34, voltage: 230.0, power: 46.822, time: "2017-06-02 12:25:28"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 75.328, time: "2017-06-02 12:26:28"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 73.837, time: "2017-06-02 12:27:28"},
  {el_socket_id: 1, i_current: 0.33, voltage: 230.0, power: 74.402, time: "2017-06-02 12:28:29"},
  {el_socket_id: 1, i_current: 0.33, voltage: 230.0, power: 75.426, time: "2017-06-02 12:29:29"},
  {el_socket_id: 1, i_current: 0.0, voltage: 230.0, power: 42.477, time: "2017-06-02 12:30:29"},
  {el_socket_id: 1, i_current: 0.3, voltage: 230.0, power: 59.059, time: "2017-06-02 12:31:29"},
  {el_socket_id: 1, i_current: 0.0, voltage: 230.0, power: 47.053, time: "2017-06-02 12:32:30"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 62.8, time: "2017-06-02 12:33:30"},
  {el_socket_id: 1, i_current: 0.31, voltage: 230.0, power: 73.122, time: "2017-06-02 12:34:31"},
  {el_socket_id: 1, i_current: 0.31, voltage: 230.0, power: 73.447, time: "2017-06-02 12:35:31"},
  {el_socket_id: 1, i_current: 0.33, voltage: 230.0, power: 74.213, time: "2017-06-02 12:36:31"},
  {el_socket_id: 1, i_current: 0.34, voltage: 230.0, power: 76.081, time: "2017-06-02 12:37:31"},
  {el_socket_id: 1, i_current: 0.33, voltage: 230.0, power: 76.039, time: "2017-06-02 12:38:31"},
  {el_socket_id: 1, i_current: 0.32, voltage: 230.0, power: 75.802, time: "2017-06-02 12:39:32"},
  {el_socket_id: 1, i_current: 0.33, voltage: 230.0, power: 75.761, time: "2017-06-02 12:40:32"},
  {el_socket_id: 1, i_current: 0.33, voltage: 230.0, power: 75.496, time: "2017-06-02 12:41:32"},
])
