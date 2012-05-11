class ApplicationController < ActionController::Base
  protect_from_forgery

  http_basic_authenticate_with :name => "frodo", :password => "thering", :except => [:landingpage, :overview, :create, :unsubscribe]


  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  private
  def render_404(exception)
    notify_airbrake(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'errors/error_404', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    notify_airbrake(exception)
    @error = exception
    respond_to do |format|
      format.html { render template: 'errors/error_500', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end


end
