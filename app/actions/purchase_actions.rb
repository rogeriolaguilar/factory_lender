# frozen_string_literal: true

module PurchaseActions
  def self.build_purchase(invoice, fee_strategy)
    period = invoice.due_date.to_date - Date.today
    amount = fee_strategy.accrue_fee(invoice.amount, period)
    Purchase.new({ external_id: SecureRandom.uuid, amount:, invoice: })
  end
end
