# frozen_string_literal: true

class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :external_id, :amount
  has_one :invoice
end
