# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |error|
    render_error(error, :not_found)
  end

  rescue_from ActiveModel::ForbiddenAttributesError do |_error|
    render_error(error, :unprocessable_entity)
  end

  rescue_from ActiveRecord::RecordInvalid do |error|
    render_error(error, :unprocessable_entity)
  end

  rescue_from ActionController::ParameterMissing do |error|
    render_error(error, :unprocessable_entity)
  end

  def render_error(error, status)
    render json: {errors: [error&.message] }, status: status
  end
end
