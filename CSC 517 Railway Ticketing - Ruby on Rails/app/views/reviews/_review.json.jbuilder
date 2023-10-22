json.extract! review, :id, :passenger_id, :train_id, :rating, :feedback, :created_at, :updated_at
json.url review_url(review, format: :json)
