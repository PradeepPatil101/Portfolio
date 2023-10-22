json.extract! passenger, :id, :first_name, :last_name,
              :email, :phone_number, :street_name, :street_name2, :city, :state, :zip,
              :credit_card_info, :created_at, :updated_at
json.url passenger_url(passenger, format: :json)
