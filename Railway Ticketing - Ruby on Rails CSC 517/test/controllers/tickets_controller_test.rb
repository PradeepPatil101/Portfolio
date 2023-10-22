require "test_helper"
require 'devise'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::ControllerHelpers
  setup do
    @ticket = tickets(:one)
    @passenger = passengers(:one)
    sign_in @passenger
  end

  test "should get index" do
    get tickets_url
    assert_response :success
  end

  # test "should get new" do
  #   get new_ticket_url
  #   assert_response :success
  # end
  #
  # test "should create ticket" do
  #   assert_difference('Ticket.count') do
  #     post tickets_url, params: { ticket: { confirmation_number: @ticket.confirmation_number, passenger_id: @ticket.passenger_id, train_id: @ticket.train_id } }
  #   end
  #
  #   assert_redirected_to ticket_url(Ticket.last)
  # end
  #
  # test "should show ticket" do
  #   get ticket_url(@ticket)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_ticket_url(@ticket)
  #   assert_response :success
  # end
  #
  # test "should update ticket" do
  #   patch ticket_url(@ticket), params: { ticket: { confirmation_number: @ticket.confirmation_number, passenger_id: @ticket.passenger_id, train_id: @ticket.train_id } }
  #   assert_redirected_to ticket_url(@ticket)
  # end
  #
  # test "should destroy ticket" do
  #   assert_difference('Ticket.count', -1) do
  #     delete ticket_url(@ticket)
  #   end
  #
  #   assert_redirected_to tickets_url
  # end
end
