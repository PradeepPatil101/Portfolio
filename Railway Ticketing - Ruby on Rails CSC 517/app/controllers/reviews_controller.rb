class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :check_review_owner_or_admin, only: [:edit, :update, :destroy]
  before_action :ensure_logged_in, only: [:new, :create]

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all

    if params[:first_name].present? && params[:train_number].present?
      passenger = Passenger.find_by(first_name: params[:first_name])
      train = Train.find_by(train_number: params[:train_number])

      # Check if both passenger and train exist, and then filter reviews
      if passenger && train
        @reviews = @reviews.joins(:passenger).where("passengers.first_name LIKE ? AND train_id = ?", "%#{params[:first_name]}%", train.id)
      else
        # No matching passenger or train found, return no reviews
        @reviews = Review.none
      end
    elsif params[:first_name].present?
      @reviews = @reviews.joins(:passenger).where("passengers.first_name LIKE ?", "%#{params[:first_name]}%")
    elsif params[:train_number].present?
      train = Train.find_by(train_number: params[:train_number])
      @reviews = train ? train.reviews : Review.none
    end
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
    def new
    if current_user.is_a?(Admin)
      @train = Train.all # or however you want to select trains for admin
      @review = Review.new
    else
      @train = Train.find(params[:train_id]) if params[:train_id]
      if @train && current_user.trains.include?(@train)
        @review = Review.new
      else
        redirect_to reviews_path, alert: "You can only review trains you've ridden on."
      end
    end
  end

  # to create the admin review options needed to only let admins create reviews
  # when a passenger has ridden the train so that it does not cause errors.
  def eligible_trains
    passenger = Passenger.find(params[:passenger_id])

    # Get the IDs of the trains that the passenger has tickets for.
    ticketed_train_ids = passenger.tickets.pluck(:train_id)

    # Get the IDs of the trains the passenger has already reviewed.
    reviewed_train_ids = passenger.reviews.pluck(:train_id)

    # Filter out trains which the passenger hasn't got a ticket for or has already reviewed.
    @eligible_trains = Train.where(id: ticketed_train_ids).where.not(id: reviewed_train_ids)

    render json: @eligible_trains.select(:id, :train_number)
  end




  # POST /reviews or /reviews.json
      def create
      @review = Review.new(review_params)

      if current_user.is_a?(Admin)
        @review.passenger_id = params[:review][:passenger_id] # Assuming you'll provide a dropdown for admins to select a passenger
      else
        @review.passenger_id = current_user.id
      end

      # This check ensures that a passenger is only reviewing a train they've taken,
      # but allows admins to bypass this requirement
      if current_user.is_a?(Admin) || current_user.trains.include?(@review.train)
        respond_to do |format|
          if @review.save
            format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
            format.json { render :show, status: :created, location: @review }
            calculate_set_rating(@review.train_id)
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @review.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to reviews_path, alert: "You can only review trains you've ridden on."
      end
    end



  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      # Remove the :passenger_id attribute from the update
      review_params_without_passenger_id = review_params.except(:passenger_id)

      if @review.update(review_params_without_passenger_id)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }

        # Calculate and update the train's rating
        calculate_set_rating(@review.train_id)
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy

    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
      calculate_set_rating(@review.train_id)
    end
  end

  # Separate manage reviews page for the passengers to see only their reviews.
  def manage_reviews
    if session[:admin]
      @reviews = Review.all
    elsif current_user
      @reviews = current_user.reviews
      booked_train_ids = current_user.tickets.pluck(:train_id)
      reviewed_train_ids = current_user.reviews.pluck(:train_id)
      @unreviewed_trains = Train.where(id: booked_train_ids - reviewed_train_ids)
    else
      redirect_to root_path, alert: "You must be logged in to manage your reviews."
    end
  end

  private
  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :feedback, :train_id)
  end

  def check_review_owner_or_admin
    unless current_user && (current_user == @review.passenger || session[:admin])
      redirect_to reviews_path, alert: "You don't have permission to perform this action."
    end
  end

  def ensure_logged_in
    unless current_user
      redirect_to root_path, alert: "You must be logged in to perform this action."
    end
  end

  def calculate_set_rating(train_id)
    @all_reviews_for_train = Review.where(train_id: train_id)

    total_rating = @all_reviews_for_train.sum(:rating)
    total_reviews_count = @all_reviews_for_train.count

    if total_reviews_count > 0
      average_rating = total_rating.to_f / total_reviews_count

      train = Train.find_by(id: train_id)

      if train
        train.update(rating: average_rating)
      else
      end
    else
    end
  end

end
