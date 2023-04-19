# frozen_string_literal: true

class Purchase < ApplicationRecord
  validates :invoice, :amount, :external_id, presence: true
  validates :amount, numericality: true
  belongs_to :invoice

  def self.by_invoice_external_id(invoice_external_id)
    Purchase.joins(:invoice).where({ invoice: { external_id: invoice_external_id } })
  end
end
