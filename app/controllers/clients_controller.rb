# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show update destroy]
  before_action :permit_params, only: %i[create update]

  def show
    render json: @client
  end

  def create
    @client = ClientActions.build_client(permit_params)

    @client.save!
    render json: @client, status: :created, location: @client
  end

  def update
    if permit_params.empty?
      handle_errors
    elsif @client.update!(permit_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
  end

  private

  def set_client
    @client = Client.find_by!(external_id: params[:external_id])
  end

  def permit_params
    params.require(:client).permit(:name)
  end

  def handle_errors
    render json: { "errors": ['invalid params'] }, status: :unprocessable_entity
  end
end
