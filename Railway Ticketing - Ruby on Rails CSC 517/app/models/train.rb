class Train < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :passengers, through: :tickets
  has_many :reviews, dependent: :destroy

  validate :arrival_after_departure
  validates :train_number, uniqueness: { case_sensitive: false }, presence: true
  validates :departure_station, presence: true
  validates :termination_station, presence: true
  validates :departure_date, presence: true
  validates :departure_time, presence: true
  validates :arrival_date, presence: true
  validates :arrival_time, presence: true
  validates :ticket_price, presence: true
  validates :train_capacity, presence: true
  validates :seats_left, presence: true
  validates :seats_left, numericality: { greater_than_or_equal_to: 0 }
  validates :ticket_price, numericality: { greater_than_or_equal_to: 1 }

  def self.available_trains
    where("(departure_date = ? AND departure_time > ?) OR departure_date > ?", Date.today, Time.now.strftime('%T'), Date.today)
  end

  private

  # Custom validation
  def arrival_after_departure
    return if arrival_date.blank? || departure_date.blank?

    if arrival_date < departure_date
      errors.add(:arrival_date, "can't be before departure date")
    elsif arrival_date == departure_date && arrival_time <= departure_time
      errors.add(:arrival_time, "can't be before or equal to departure time on the same day")
    end
  end
end
