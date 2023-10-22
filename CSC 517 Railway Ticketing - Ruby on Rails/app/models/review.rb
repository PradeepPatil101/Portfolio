class Review < ApplicationRecord
  belongs_to :passenger, optional: true
  belongs_to :admin, optional: true
  belongs_to :train

  validate :review_allowed

  private

  def review_allowed
    if passenger.present?
      unless passenger.trains.include?(train)
        errors.add(:base, "Passenger can only review trains they have ridden on.")
      end
    elsif admin.blank?
      errors.add(:base, "Only passengers who have ridden the train or admins can leave reviews.")
    end
  end

  def self.has_reviewed?(passenger, train)
    where(passenger: passenger, train: train).exists?
  end

end