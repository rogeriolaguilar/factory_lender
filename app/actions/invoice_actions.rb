# frozen_string_literal: true

module InvoiceActions
  def self.build_invoice(params, client)
    Invoice.new({ status: Invoice::STATUS_CREATED,
                  external_id: SecureRandom.uuid,
                  amount: params[:amount],
                  due_date: params[:due_date],
                  document_url: params[:document_url],
                  client: })
  end

  def self.update_invoice(invoice, params)
    invoice.assign_attributes(params)
    invoice
  end

  def self.change_invoice_status(invoice, status)
    if status
      next_permitted_status = Invoice::NEXT_STATUS_MAP[invoice.status]

      unless next_permitted_status.include?(status)
        raise Errors::WrongInvoiceStatusError,
              "Invalid status. Current status: #{invoice.status}. Next permitted status are: #{next_permitted_status}"
      end
    end

    invoice.status = status
    invoice
  end
end
