class Passenger < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :trains, through: :tickets
  has_many :reviews, dependent: :destroy

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Validations
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX, message: "is not a valid email format" }
  validates :password, presence: true, length: {minimum: 6, maximum: 20}, on: :create
  validates :first_name, presence: true, length: {minimum: 1, maximum: 20}
  validates :last_name, presence: true, length: {minimum: 1, maximum: 20}
  validates :street_name, presence: true, format: { with: /\A[a-zA-Z0-9\s]+\z/,
                                                    message: "can only contain letters, numbers, and spaces" }
  validates :street_name2, format: { with: /\A[a-zA-Z0-9\s]*\z/,
                                     message: "can only contain letters, numbers, and spaces" },
            allow_blank: true
  validates :city, presence: true, format: { with: /\A[a-zA-Z\s]+\z/,
                                             message: "can only contain letters" }, length: { maximum: 50}
  validates :state, presence: true, format: { with: /\A[a-zA-Z]{2}\z/, message: "must be exactly 2 letters long" }
  validates :zip, presence: true, format: { with: /\A\d{5}\z/, message: "must be exactly 5 digits long" }
  validates :phone_number, presence: true,
            format: { with: /\A\d{3}-\d{3}-\d{4}\z/,
                      message: "must be in XXX-XXX-XXXX format" }
  validates :credit_card_info, presence: true,
            format: { with: /\A\d{4}-\d{4}-\d{4}-\d{4}\z/,
                      message: "must be in XXXX-XXXX-XXXX-XXXX format" }


  def full_name
    "#{first_name} #{last_name}"
  end

end
