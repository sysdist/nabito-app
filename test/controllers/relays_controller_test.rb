require 'test_helper'

class RelaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @relay = relays(:one)
  end

  test "should get index" do
    get relays_url
    assert_response :success
  end

  test "should get new" do
    get new_relay_url
    assert_response :success
  end

  test "should create relay" do
    assert_difference('Relay.count') do
      post relays_url, params: { relay: { el_socket_id: @relay.el_socket_id, is_on: @relay.is_on, name: @relay.name, pin_id: @relay.pin_id, pin_num: @relay.pin_num } }
    end

    assert_redirected_to relay_url(Relay.last)
  end

  test "should show relay" do
    get relay_url(@relay)
    assert_response :success
  end

  test "should get edit" do
    get edit_relay_url(@relay)
    assert_response :success
  end

  test "should update relay" do
    patch relay_url(@relay), params: { relay: { el_socket_id: @relay.el_socket_id, is_on: @relay.is_on, name: @relay.name, pin_id: @relay.pin_id, pin_num: @relay.pin_num } }
    assert_redirected_to relay_url(@relay)
  end

  test "should destroy relay" do
    assert_difference('Relay.count', -1) do
      delete relay_url(@relay)
    end

    assert_redirected_to relays_url
  end
end
