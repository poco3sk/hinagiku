class ErrorsController < ApplicationController
  def not_found
    raise ActionController::RoutingError, "No route matched #{request.path.inspect}"
  end
end