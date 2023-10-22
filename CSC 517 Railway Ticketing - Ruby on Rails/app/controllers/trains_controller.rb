class TrainsController < ApplicationController
  before_action :set_train, only: %i[ show edit update destroy ]
  before_action :require_admin, only: [ :new, :edit, :update, :destroy]
  # GET /trains or /trains.json

  def index
    if session[:admin]
      @trains = Train.all
    else
      # Restrict passengers from seeing trains with 0 seats left
      @trains = Train.where("seats_left > ?", 0).available_trains
    end

    if params[:departure_station].present?
      @trains = @trains.where(departure_station: params[:departure_station])
    end

    if params[:termination_station].present?
      @trains = @trains.where(termination_station: params[:termination_station])
    end

    if params[:rating].present?
      @trains = @trains.select { |train| train.rating.to_f >= params[:rating].to_f }
    end
  end


  # GET /trains/1 or /trains/1.json
  # GET /trains/1 or /trains/1.json
  def show
    if current_user && (current_user == @train.passengers.find_by(id: current_user.id) || session[:admin])
      # User owns the ticket or is an admin, so they can access the train page
    elsif Time.zone.parse(@train.departure_date.to_s + ' ' + @train.departure_time.to_s) > Time.current
      # Check if the train has not yet departed
      redirect_to trains_url, alert: "You cannot access this train as the train has not yet departed."
    else
      # User does not own the ticket and the train has already departed
      redirect_to trains_url, alert: "You cannot access this train as the train has already departed."
    end
  end

  # GET /trains/new
  def new
    @train = Train.new
  end

  # GET /trains/1/edit
  def edit
  end

  # POST /trains or /trains.json
  def create
    @train = Train.new(train_params)

    respond_to do |format|
      if @train.save
        format.html { redirect_to train_url(@train), notice: "Train was successfully created." }
        format.json { render :show, status: :created, location: @train }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @train.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trains/1 or /trains/1.json
  def update
    respond_to do |format|
      if @train.update(train_params)
        format.html { redirect_to train_url(@train), notice: "Train was successfully updated." }
        format.json { render :show, status: :ok, location: @train }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @train.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trains/1 or /trains/1.json
  def destroy
    @train.destroy

    respond_to do |format|
      format.html { redirect_to trains_url, notice: "Train was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_train
      @train = Train.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def train_params
      params.require(:train).permit(:train_number, :departure_station, :termination_station, :departure_date, :departure_time, :arrival_date, :arrival_time, :ticket_price, :train_capacity, :seats_left, :rating)
    end
end
