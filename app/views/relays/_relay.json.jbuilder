json.extract! relay, :id, :el_socket_id, :name, :pin_num, :pin_id, :is_on, :created_at, :updated_at
json.url relay_url(relay, format: :json)
