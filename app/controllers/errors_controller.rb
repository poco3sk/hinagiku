class ErrorsController < ApplicationController
  skip_before_filter :authenticate_user

  def not_found
    raise ActionController::RoutingError, "No route matched #{request.path.inspect}"
  end
end