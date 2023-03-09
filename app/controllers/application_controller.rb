class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    # memoized current_user, if available it will return directly
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:alert_fail] = 'You are not allowed to perform this action!'
      redirect_to login_path
    end
  end
end
