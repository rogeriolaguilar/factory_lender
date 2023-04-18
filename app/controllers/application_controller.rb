# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |error|
    render json: { "errors": [error.message] }, status: :not_found
  end

  rescue_from ActiveModel::ForbiddenAttributesError do |_error|
    render json: { "errors": ['invalid params'] }, status: :unprocessable_entity
  end
end
