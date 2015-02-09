class BaseController < ApplicationController

	rescue_from ActiveRecord::RecordNotFound,     :with => :record_not_found
  rescue_from ActionController::RoutingError, with: :no_route_matches
  rescue_from ActionController::UnpermittedParameters, ActionController::ParameterMissing, with: :strong_parameters_handler
  rescue_from ActiveRecord::UnknownAttributeError, with: :unknown_attribute_error


  protected
  	def record_not_found exception
    render status: 404, json: {message: "Record not found"}
  end

  def strong_parameters_handler exception
    render status: 400, json: { message: "Invalid params #{exception.message.capitalize}" }
  end

  def unknown_attribute_error error
  	render status: 404, json: { message: error.message }
  end

  def no_route_matches exception
    render status: 404, json: { message: exception.message }
  end
end