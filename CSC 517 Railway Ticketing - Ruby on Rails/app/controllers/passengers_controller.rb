class PassengersController < ApplicationController
  before_action :set_passenger, only: %i[ show edit update destroy ]
  before_action :require_same_user, except: [:new, :create, :index]

  # GET /passengers or /passengers.json
  def index
    if !session[:admin]
      flash[:notice] = "Only admins can view this."
      redirect_to login_path
      else
      @passengers = Passenger.all
      end
  end

  # GET /passengers/1 or /passengers/1.json
  def show
    @credit_card_info = "XXXX-XXXX-XXXX-" + @passenger.credit_card_info[-4..]
  end

  # GET /passengers/new
  def new
    if !session[:user_id] or session[:admin]
      @passenger = Passenger.new
    else
      redirect_to root_url
    end
  end

  # GET /passengers/1/edit
  def edit
    @credit_card_info = "XXXX-XXXX-XXXX-" + @passenger.credit_card_info[-4..]
  end

  # POST /passengers or /passengers.json
  def create
    @passenger = Passenger.new(passenger_params)
    respond_to do |format|
      if @passenger.save
        format.html { redirect_to root_url, notice: "Passenger was successfully created." }
        format.json { render :show, status: :created, location: @passenger }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /passengers/1 or /passengers/1.json
  def update
    puts "Received parameters: #{passenger_params.inspect}"
    respond_to do |format|
      update_params = passenger_params

      # Remove password and password_confirmation fields if both are blank
      if update_params[:password].blank? && update_params[:password_confirmation].blank?
        update_params.delete(:password)
        update_params.delete(:password_confirmation)
        # If only password is blank but confirmation is not, remove password
      elsif update_params[:password].blank?
        update_params.delete(:password)
      end

      # Remove credit_card_info if it's blank
      update_params.delete(:credit_card_info) if update_params[:credit_card_info].blank?

      if @passenger.update(update_params)
        format.html { redirect_to passenger_url(@passenger), notice: "Passenger was successfully updated." }
        format.json { render :show, status: :ok, location: @passenger }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /passengers/1 or /passengers/1.json


    def destroy
      @passenger.destroy

      # Clear the session only if the destroyed passenger was the logged in user
      session[:user_id] = nil if session[:user_id] == @passenger.id

      respond_to do |format|
        format.html { redirect_to passengers_url, notice: "Passenger was successfully destroyed." }
        format.json { head :no_content }
      end

    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_passenger
      @passenger = Passenger.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def passenger_params
    params.require(:passenger).permit(
      :email, :password, :phone_number, :credit_card_info, :password_confirmation,
      :first_name, :last_name, :street_name, :street_name2, :city, :state, :zip
    )
  end

  def require_same_user
    if session[:user_id] != @passenger.id && !session[:admin]
      flash[:notice] = "You can only edit or delete your own profile."
      redirect_to root_url
    end
  end

end
