class AdminsController < ApplicationController
  before_action :set_admin, only: %i[ show edit update destroy ]
  before_action :require_admin, except: [:new, :create]

  # GET /admins or /admins.json
  def index
    @admins = Admin.all
  end

  # GET /admins/1 or /admins/1.json
  def show
  end

  # Checks to see if an admin account exists, if not allows the creation of one account.
  def new
    if Admin.exists?
      flash[:notice] = "The admin account already exists."
      redirect_to admins_path
    else

      @admin = Admin.new
      @hide_some_field = false
    end
  end

  def passenger_search
    redirect_to root_path unless session[:admin]
  end

  def search_results
    if params[:train_id].present?
      @train = Train.find(params[:train_id])
      @tickets = @train.tickets
    else
      @tickets = Ticket.none
    end
    render :passenger_search
  end


  # added to allow for an admin account to be added when populating the database for the
  # first time only. We can remove if they want it done backend only.
  def create
    if Admin.exists?
      flash[:notice] = "The admin account already exists."
      redirect_to admins_path
    else

      @admin = Admin.new(admin_params)
      @admin.username = "admin"
      if @admin.save
        flash[:notice] = "Admin was created successfully."
        redirect_to root_url
      else
        render 'new'
      end
    end
  end

  # GET /admins/1/edit
  def edit
    @hide_some_field = true
  end

  # PATCH/PUT /admins/1 or /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admins_path, notice: "Admin was successfully updated." }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /admins/1 or /admins/1.json
  def destroy
    flash[:notice] = "You cannot delete your own admin account."
    redirect_to admins_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit( :name, :email, :phone_number, :address, :credit_number, :password)
    end
end
