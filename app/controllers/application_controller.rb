class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_coop
  before_action :track_usage

  include TimeHelper

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def track_usage
    usage = Usage.new
    if current_user
      usage.user_id = current_user.id
      usage.coop_id = current_user.coop_id
      usage.admin = current_user.admin
    end
    usage.controller = params[:controller]
    usage.action = params[:action]
    usage.path = request.original_url
    usage.ip_addr = request.remote_ip
    usage.when = Time.now
    if usage.save
      logger.info usage.inspect
    else
      logger.info "save failed for usage: #{usage.inspect}"
    end
  end

  def current_coop
    @current_coop ||= Coop.find(session[:coop_id]) if session[:coop_id]
  end
end
