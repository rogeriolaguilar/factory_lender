# frozen_string_literal: true

class PurchaseSerializer < ActiveModel::Serializer
  attributes :external_id, :amount, :invoice_id, :created_at, :updated_at
  def invoice_id
    object.invoice&.external_id
  end

  def amount
    object.amount.to_f
  end
end
