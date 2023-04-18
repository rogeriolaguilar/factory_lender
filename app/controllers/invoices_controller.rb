# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show update destroy]

  def index
    invoices = client.invoices
    render json: invoices
  end

  def show
    render json: @invoice
  end

  def create
    invoice = InvoiceActions.build_invoice(permit_params, client)
    invoice.save!
    render json: invoice, status: :created
  end

  def update
    if @invoice.update(permit_params)
      render json: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @invoice.destroy
  end

  private

  def client
    @client ||= Client.find_by!(external_id: params[:client_external_id])
  end

  def set_invoice
    @invoice = client.invoices.find_by(external_id: params[:external_id])
  end

  def permit_params
    params.require(:invoice).permit(:amount, :due_date, :status)
  end
end
