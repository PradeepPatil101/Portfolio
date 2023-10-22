class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    # check the session created to see if :admin is true or false.
    # Create session accordingly.
    if session[:admin]
      @current_user ||= Admin.find(session[:user_id])
      @current_user ||= Admin.find(session[:admin])
    elsif session[:user_id]
      @current_user ||= Passenger.find(session[:user_id])
    else
      @current_user = nil
    end
  end


  def admin_logged_in?
    # !! turns into a bool
    !!session[:admin]
  end

  def require_admin
    unless admin_logged_in?
      flash[:alert] = "You must be logged in as admin to perform that action."
      redirect_to login_path
    end
  end

  def user_logged_in?
    # !! turns current user into a bool
    !!current_user
  end

  def require_user
    unless user_logged_in?
      flash[:alert] = "You must be logged in to perform that action."
      redirect_to login_path
    end
  end

  # to redirect when incorrect urls are provided
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    flash[:alert] = "The requested resource was not found."
    redirect_to root_url
  end

  #
  rescue_from ActionController::ParameterMissing do |exception|
    # Redirect to the root URL
    redirect_to root_url, alert: "An error occurred. Please try again."
  end

end

