# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show update destroy]
  before_action :permit_params, only: %i[create update]
  rescue_from ActiveModel::ForbiddenAttributesError, with: :handle_errors

  # GET /clients/:external-id
  def show
    render json: @client
  end

  # POST /clients
  def create
    @client = Client.new(permit_params.merge(external_id: SecureRandom.uuid))

    if @client.save
      render json: @client, status: :created, location: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/:external_id
  def update
    if permit_params.empty?
      handle_errors
    elsif @client.update!(permit_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/:external_id
  def destroy
    @client.destroy
  end

  private

  def set_client
    @client = Client.find_by(external_id: params[:external_id])
  end

  def permit_params
    params.require(:client).permit(:name)
  end

  def handle_errors
    render json: { "errors": ['invalid params'] }, status: :unprocessable_entity
  end
end
