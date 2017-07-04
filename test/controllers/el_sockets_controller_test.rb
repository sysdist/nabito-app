require 'test_helper'

class ElSocketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @el_socket = el_sockets(:one)
  end

  test "should get index" do
    get el_sockets_url
    assert_response :success
  end

  test "should get new" do
    get new_el_socket_url
    assert_response :success
  end

  test "should create el_socket" do
    assert_difference('ElSocket.count') do
      post el_sockets_url, params: { el_socket: { address: @el_socket.address, code: @el_socket.code, current_user: @el_socket.current_user, gps_lat: @el_socket.gps_lat, gps_lng: @el_socket.gps_lng, i_limit: @el_socket.i_limit, in_use: @el_socket.in_use, price_per_kWh: @el_socket.price_per_kWh, url: @el_socket.url, user_id: @el_socket.user_id, voltage: @el_socket.voltage } }
    end

    assert_redirected_to el_socket_url(ElSocket.last)
  end

  test "should show el_socket" do
    get el_socket_url(@el_socket)
    assert_response :success
  end

  test "should get edit" do
    get edit_el_socket_url(@el_socket)
    assert_response :success
  end

  test "should update el_socket" do
    patch el_socket_url(@el_socket), params: { el_socket: { address: @el_socket.address, code: @el_socket.code, current_user: @el_socket.current_user, gps_lat: @el_socket.gps_lat, gps_lng: @el_socket.gps_lng, i_limit: @el_socket.i_limit, in_use: @el_socket.in_use, price_per_kWh: @el_socket.price_per_kWh, url: @el_socket.url, user_id: @el_socket.user_id, voltage: @el_socket.voltage } }
    assert_redirected_to el_socket_url(@el_socket)
  end

  test "should destroy el_socket" do
    assert_difference('ElSocket.count', -1) do
      delete el_socket_url(@el_socket)
    end

    assert_redirected_to el_sockets_url
  end
end
