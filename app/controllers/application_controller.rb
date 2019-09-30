# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user, :authenticate!

  # Prevents these methods from being invoked from a route
  protected

  def set_current_user
    @current_user = Moviegoer.where(id: session[:user_id]).first
  end

  def authenticate!
    unless @current_user
      redirect_to OmniAuth.login_path(:provider)
      # redirect_to OmniAuth.login_path(:facebook)
    end
  end
end