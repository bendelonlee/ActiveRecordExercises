class SessionsController < ApplicationController
  def create
    user = User.from_google_auth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.name}"
    redirect_to '/'
  end

end
