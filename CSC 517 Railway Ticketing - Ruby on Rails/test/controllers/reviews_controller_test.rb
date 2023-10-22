require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review = reviews(:one)
    @passenger = passengers(:one)

  end

  test 'should get index' do
    get reviews_url
    assert_response :success
    assert_not_nil assigns(:reviews)
  end

  test 'should create review' do
    passenger = passengers(:passenger_user)
    train = trains(:one)

    before_count = Review.count

    session = ActionController::TestSession.new
    session[:user_id] = passenger.id

    post reviews_url, params: {
      review: {
        rating: 5,
        feedback: 'Decent service',
        train_id: train.id
      }
    }

  # assert_redirected_to review_path(assigns(:review))

    assert_equal before_count + 1, Review.count
  end
  #
  # test 'should filter reviews by user name' do
  #   # Create reviews with different passenger names
  #   Review.create(passenger: passengers(:one), train: trains(:one), rating: 4, feedback: 'Good service')
  #   Review.create(passenger: passengers(:two), train: trains(:two), rating: 3, feedback: 'Average service')
  #   Review.create(passenger: passengers(:three), train: trains(:three), rating: 5, feedback: 'Excellent service')
  #
  #   # Provide a user name for filtering
  #   user_name = passengers(:two).name
  #
  #   get :index, params: { user_name: user_name }
  #
  #   # Assert that the response is successful
  #   assert_response :success
  #
  #   # Assert that only the reviews of the specified user are present in the response
  #   assert_select '.review' do
  #     assert_select '.passenger-name', count: 1
  #     assert_select '.passenger-name', text: user_name
  #   end
  # end
  #
  # test 'should filter reviews by train number' do
  #   # Create reviews for different trains
  #   Review.create(passenger: passengers(:one), train: trains(:one), rating: 4, feedback: 'Good service')
  #   Review.create(passenger: passengers(:two), train: trains(:two), rating: 3, feedback: 'Average service')
  #   Review.create(passenger: passengers(:three), train: trains(:three), rating: 5, feedback: 'Excellent service')
  #
  #   # Provide a train number for filtering
  #   train_number = trains(:two).train_number
  #
  #   get :index, params: { train_number: train_number }
  #
  #   # Assert that the response is successful
  #   assert_response :success
  #
  #   # Assert that only the reviews for the specified train are present in the response
  #   assert_select '.review' do
  #     assert_select '.train-number', count: 1
  #     assert_select '.train-number', text: train_number
  #   end
  # end
  #
  # test 'should update a review' do
  #   # Assuming you have fixtures set up for a review, passenger, and train
  #   review = reviews(:one)
  #   passenger = passengers(:one)
  #   train = trains(:one)
  #
  #   # Log in as the passenger who owns the review
  #   sign_in passenger
  #
  #   # Attempt to update the review
  #   patch :update, params: {
  #     id: review.id,
  #     review: {
  #       rating: 5,
  #       feedback: 'Excellent service',
  #       train_id: train.id
  #     }
  #   }
  #
  #   # Assert that the response redirects to the updated review's page
  #   assert_redirected_to review_path(review)
  #
  #   # Assert that the flash notice is set
  #   assert_not flash.empty?
  #   assert_equal 'Review was successfully updated.', flash[:notice]
  #
  #   # Reload the review from the database to ensure changes were saved
  #   review.reload
  #
  #   # Assert that the review attributes were updated correctly
  #   assert_equal 5, review.rating
  #   assert_equal 'Excellent service', review.feedback
  #   assert_equal train.id, review.train_id
  # end


end
