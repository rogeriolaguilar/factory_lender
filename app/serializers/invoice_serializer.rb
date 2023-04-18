# frozen_string_literal: true

class InvoiceSerializer < ActiveModel::Serializer
  attributes :external_id, :amount, :due_date, :status, :created_at, :updated_at, :client_id
  def client_id
    object.client.external_id
  end

  def amount
    object.amount.to_f
  end
end
