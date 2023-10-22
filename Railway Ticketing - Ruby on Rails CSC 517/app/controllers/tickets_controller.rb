class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :check_admin_or_ticket_owner, only: [:destroy]
  before_action :check_admin, only: [:edit, :update]

  # GET /tickets or /tickets.json
  def index
    if session[:admin]
      @tickets = Ticket.all
      @purchased_for_others_tickets = [] # Setting it to an empty array for admin since they don't need to see it
    elsif current_user && current_user.respond_to?(:tickets)
      @tickets = current_user.tickets.includes(:passenger).includes(:train)
      @purchased_for_others_tickets = Ticket.where(purchaser_id: current_user.id).where.not(passenger_id: current_user.id).includes(:passenger).includes(:train)
    else
      redirect_to root_path, alert: "You must be logged in to view tickets."
    end
  end


  # GET /tickets/1 or /tickets/1.json
  def show

  end

  # GET /tickets/new
  def new
    if !session[:user_id]
      flash[:notice] = "You must be logged in."
      redirect_to login_path
    elsif !session[:admin]
      redirect_to trains_path
    else
      @ticket = Ticket.new
      @trains = Train.all
      @passengers = Passenger.all
    end
  end


  # GET /tickets/1/edit
  def edit
  end


  # end
  # POST /tickets or /tickets.json
  def create
    # Check if the current user is an admin
    if session[:admin]
      # Admin can create tickets for any train
      @ticket = Ticket.new(ticket_params)
      train = Train.find(params[:ticket][:train_id])
      @ticket.price = train.ticket_price

      if @ticket.save
        redirect_to ticket_url(@ticket), notice: "Ticket was successfully created by admin."
      else
        render :new, alert: "There was an error creating the ticket."
      end
    else
      # Logic for regular users purchasing tickets
      train = Train.find(params[:train_id])

      # Check if the departure time has already passed
      departure_datetime = DateTime.new(
        train.departure_date.year,
        train.departure_date.month,
        train.departure_date.day,
        train.departure_time.hour,
        train.departure_time.min,
        train.departure_time.sec
      )

      if departure_datetime > Time.current
        @ticket = current_user.tickets.new(train: train)
        @ticket.price = train.ticket_price

        if @ticket.save
          redirect_to ticket_url(@ticket), notice: "Ticket was successfully purchased."
        else
          redirect_to trains_url, alert: "There was an error purchasing the ticket."
        end
      else
        redirect_to trains_url, alert: "You cannot purchase a ticket for a train that has already departed."
      end
    end
  end

  def new_for_another
    @train = Train.find(params[:id])
    @passengers = Passenger.where.not(id: current_user.id)
  end


  def confirm_purchase_for_another
    Rails.logger.info("Starting to purchase for another")

    train = Train.find(params[:id])
    recipient = Passenger.find_by(email: params[:email])

    if recipient
         ticket = Ticket.new(
           train_id: train.id,
           passenger_id: recipient.id,
           purchaser_id: current_user.id,
           recipient_id: recipient.id,
           price: train.ticket_price)
      if ticket.save
        redirect_to tickets_path, notice: "Successfully purchased ticket for #{recipient.first_name} #{recipient.last_name}!"
      else
        redirect_to purchase_for_another_passenger_path(train.id), alert: "Error purchasing the ticket."
      end
    else
      redirect_to trains_url, alert: "No passenger found with that email."
    end
  end





  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    # Here, only the admin can reach this since Passenger should only be able to cancel ("delete")
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: "Ticket was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy

    departure_datetime = DateTime.new(
      @ticket.train.departure_date.year,
      @ticket.train.departure_date.month,
      @ticket.train.departure_date.day,
      @ticket.train.departure_time.hour,
      @ticket.train.departure_time.min,
      @ticket.train.departure_time.sec
    )

    if session[:admin] || departure_datetime > Time.current
      @ticket.destroy
      flash[:success] = "Ticket was successfully canceled."
    else
      flash[:alert] = "Ticket cannot be canceled after the train's departure time."
    end

    redirect_to tickets_path

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      
      params.require(:ticket).permit(:passenger_id, :train_id, :confirmation_number)

    end

  def check_admin_or_ticket_owner
    unless current_user && (current_user == @ticket.passenger || session[:admin])
      redirect_to tickets_path, alert: "You don't have permission to perform this action."
    end
  end

  def check_admin
    redirect_to tickets_path, alert: "Only admins can edit ticket details." unless session[:admin]
  end

end
