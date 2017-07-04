json.extract! socket_monitor, :id, :el_socket_id, :current_sensor_id, :voltage_sensor_id, :nominal_voltage, :active, :frequency, :created_at, :updated_at
json.url socket_monitor_url(socket_monitor, format: :json)
