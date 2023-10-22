class Ticket < ApplicationRecord
  belongs_to :passenger
  belongs_to :train
  belongs_to :purchaser, class_name: "Passenger", foreign_key: "purchaser_id", optional: true
  belongs_to :recipient, class_name: "Passenger", foreign_key: "recipient_id", optional: true


  after_create :decrement_seats_left
  before_create :generate_confirmation_number
  before_create :check_seat_availability
  after_destroy :increment_seats_left



  private

  def generate_confirmation_number
    # Generate a unique confirmation number
    # See for more information: https://api.rubyonrails.org/classes/SecureRandom.html
    self.confirmation_number = SecureRandom.hex(4).upcase
  end

  def decrement_seats_left
    train.decrement!(:seats_left)
  end

  def check_seat_availability
    unless train.seats_left > 0
      errors.add(:base, "Sorry, no seats available on this train.")
      throw :abort
    end
  end

  def increment_seats_left
    train.increment!(:seats_left)
  end

end

