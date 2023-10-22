json.extract! admin, :id, :username, :name, :email, :password, :phone_number, :address, :credit_number, :created_at, :updated_at
json.url admin_url(admin, format: :json)
