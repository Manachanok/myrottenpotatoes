# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  # user shouldn't have to be logged in before logging in!
  skip_before_action :authenticate!
  skip_before_filter :set_current_user
  def create
    auth = request.env['omniauth.auth']
    user = Moviegoer.where(
      provider: auth['provider'], uid: auth['uid'] ).first

    unless user
      user = Moviegoer.create_with_omniauth(auth)
    end

    session[:user_id] = user.id
    redirect_to movies_path
  end

  def failure
    flash[:notice] = 'Could not login'
    redirect_to root_path
  end
  
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to movies_path
  end
  
  def loginbefore
    flash[:notice] = 'Please login!'
    redirect_to root_path
  end
end