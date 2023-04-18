# frozen_string_literal: true

module InvoiceActions
  def self.build_invoice(params, client)
    Invoice.new({ status: Invoice::STATUS_CREATED,
                  external_id: SecureRandom.uuid,
                  amount: params[:amount],
                  due_date: params[:due_date],
                  client: })
  end
end
