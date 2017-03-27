class ApplicationController < ActionController::Base
  before_action :set_request_from

  rescue_from Exception, with: :render_500

  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound,   with: :render_404

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def render_500
    render file: "#{Rails.root}/public/500.html", layout: false, status: 500
  end
end
