class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :block_ip_addresses

  def not_found
    render :file => "#{Rails.root}/public/404.html"
  end

  protected

  def block_ip_addresses
    head :unauthorized if  params[:path] == "disney/ad-master/adMaster"
  end

  def current_ip_address
    request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
  end
end
