class ApplicationController < ActionController::Base
  protect_from_forgery
  clear_helpers

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private
  def render_404(exception)
    render "errors/not_found", status: 404
  end
end
