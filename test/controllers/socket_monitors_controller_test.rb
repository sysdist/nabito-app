require 'test_helper'

class SocketMonitorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @socket_monitor = socket_monitors(:one)
  end

  test "should get index" do
    get socket_monitors_url
    assert_response :success
  end

  test "should get new" do
    get new_socket_monitor_url
    assert_response :success
  end

  test "should create socket_monitor" do
    assert_difference('SocketMonitor.count') do
      post socket_monitors_url, params: { socket_monitor: { active: @socket_monitor.active, current_sensor_id: @socket_monitor.current_sensor_id, el_socket_id: @socket_monitor.el_socket_id, frequency: @socket_monitor.frequency, nominal_voltage: @socket_monitor.nominal_voltage, voltage_sensor_id: @socket_monitor.voltage_sensor_id } }
    end

    assert_redirected_to socket_monitor_url(SocketMonitor.last)
  end

  test "should show socket_monitor" do
    get socket_monitor_url(@socket_monitor)
    assert_response :success
  end

  test "should get edit" do
    get edit_socket_monitor_url(@socket_monitor)
    assert_response :success
  end

  test "should update socket_monitor" do
    patch socket_monitor_url(@socket_monitor), params: { socket_monitor: { active: @socket_monitor.active, current_sensor_id: @socket_monitor.current_sensor_id, el_socket_id: @socket_monitor.el_socket_id, frequency: @socket_monitor.frequency, nominal_voltage: @socket_monitor.nominal_voltage, voltage_sensor_id: @socket_monitor.voltage_sensor_id } }
    assert_redirected_to socket_monitor_url(@socket_monitor)
  end

  test "should destroy socket_monitor" do
    assert_difference('SocketMonitor.count', -1) do
      delete socket_monitor_url(@socket_monitor)
    end

    assert_redirected_to socket_monitors_url
  end
end
