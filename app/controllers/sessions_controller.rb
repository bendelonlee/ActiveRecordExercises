class SessionsController < ApplicationController

  def create
    redirect_to '/'
    require 'pry'; binding.pry
  end

end
