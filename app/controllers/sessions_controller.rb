class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: params[:session][:email])
    if !user
      user = User.find_by(email: params[:session][:email].downcase)
    end

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged in successfully!'
      redirect_to user
    else
      flash.now[:alert_fail] = 'Invalid login credentials!'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully!"
    redirect_to root_path
  end
end