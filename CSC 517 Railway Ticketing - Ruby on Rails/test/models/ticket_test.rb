require "test_helper"
# Example:



class TicketTest < ActiveSupport::TestCase
  # ...

  test "validations" do
    ticket = Ticket.new(passenger: passengers(:one), train: trains(:one))
    assert ticket.valid?
  end

  test "is not valid without a passenger" do
    ticket = Ticket.new(passenger: nil, train: trains(:one))
    assert_not ticket.valid?
  end

  test "is not valid without a train" do
    ticket = Ticket.new(passenger: passengers(:one), train: nil)
    assert_not ticket.valid?
  end

  test 'generates a confirmation number before create' do
    ticket = Ticket.create(passenger: passengers(:one), train: trains(:one), passenger_id: passengers(:one).id)
    assert_not_nil ticket.confirmation_number
  end

  test 'decrements seats_left after create' do
    train = trains(:one) # Load the train fixture

    assert_difference('train.reload.seats_left', -1) do
      Ticket.create(passenger: passengers(:one), train: train, passenger_id: passengers(:one).id)
    end
  end


  test 'increments seats_left after destroy' do
    train = trains(:one) # Load the train fixture

    ticket = Ticket.create(passenger: passengers(:one), train: train)

    assert_difference('train.reload.seats_left', 1) do
      ticket.destroy
    end
  end

end
