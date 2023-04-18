# frozen_string_literal: true

class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[show update destroy]

  def index
    @purchases = Purchase.all

    render json: @purchases
  end

  def show
    render json: @purchase
  end

  def create
    @purchase = Purchase.new(purchase_params)

    if @purchase.save
      render json: @purchase, status: :created, location: @purchase
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @purchase.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def purchase_params
    params.require(:purchase).permit(:external_id, :amount, :invoice_id)
  end
end
