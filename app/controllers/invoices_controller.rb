# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :set_invoice_by_client, only: %i[show update destroy]

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
    new_invoice = InvoiceActions.update_invoice(@invoice, permit_params)
    new_invoice.save!
    render json: @invoice
  end

  def change_status
    new_invoice = InvoiceActions.change_invoice_status(invoice, params[:status])
    if new_invoice.status == Invoice::STATUS_PURCHASED
      fee_strategy = Fees::DefaultFeeStrategy.new
      purchase = PurchaseActions.build_purchase(new_invoice, fee_strategy)
    end

    ActiveRecord::Base.transaction do
      purchase&.save!
      new_invoice.save!
    end
    render json: new_invoice
  end

  def destroy
    @invoice.destroy
  end

  private

  def client
    @client ||= Client.find_by!(external_id: params[:client_external_id])
  end

  def set_invoice_by_client
    @invoice = client.invoices.find_by!(external_id: params[:external_id])
  end

  def invoice
    @invoice ||= Invoice.find_by!(external_id: params[:external_id])
  end

  def permit_params
    params.permit(:amount, :due_date, :document_url)
  end
end
