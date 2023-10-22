class Admin < ApplicationRecord
  validates :email, presence: true, uniqueness: true


    def authenticate(entered_password)
      entered_password == self.password
    end
end
