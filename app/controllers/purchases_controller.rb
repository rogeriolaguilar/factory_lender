# frozen_string_literal: true

class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[show destroy]

  def index
    purchases = Purchase.by_invoice_external_id(params[:invoice_external_id])

    render json: purchases
  end

  def show
    render json: @purchase
  end

  def destroy
    @purchase.destroy
  end

  private

  def set_purchase
    @purchase = Purchase.find_by!(external_id: params[:external_id])
  end
end
