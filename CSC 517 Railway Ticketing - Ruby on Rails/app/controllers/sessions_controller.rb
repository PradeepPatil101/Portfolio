class SessionsController < ApplicationController
  def new
  end

  def create
    user = Admin.find_by_email(params[:email_address])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:admin] = true
      redirect_to root_url
    else
      user = Passenger.find_by_email(params[:email_address])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        session[:admin] = false
        redirect_to root_url
      else
        flash.now[:alert] = "Email or password is invalid"
        render "new"
      end
    end

  end

  def destroy
    session[:admin] = nil if session[:admin]
    session[:user_id] = nil
    redirect_to root_url
  end
end
