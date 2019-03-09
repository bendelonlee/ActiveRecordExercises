class SessionsController < ApplicationController

  def create
    user = User.from_google_auth(request.env["omniauth.auth"])
    flash[:success] = "Welcome, #{user.name}"
    redirect_to '/'
  end

end
