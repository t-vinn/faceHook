class ApplicationController < ActionController::Base
  before_filter :set_request_from

  rescue_from Exception, with: :render_500

  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound,   with: :render_404

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def render_500
    render file: "#{Rails.root}/public/500.html", layout: false, status: 500
  end

  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    # save which page the user last visited
    session[:request_from] = request.original_url
  end

  def return_back
    if request.referer
      redirect_to :back and return true
    elsif @request_from
      redirect_to @request_from and return true
    end
  end
end
