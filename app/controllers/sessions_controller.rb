class SessionsController < ApplicationController
  
  def create
    @user = User.fetch(auth_hash)
    login_as @user if @user
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
