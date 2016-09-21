class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in?
      !!current_user
  end

  def set_user
    @user = nil
    if !!params[:user_id]
      if User.exists?(params[:user_id])
        @user = User.find(params[:user_id])
      else
        flash[:alert] = "User does not exist"
        home_redirect
      end
    end
  end

end
