# frozen_string_literal: true

module PurchaseActions
  DAILY_FEE = 0.1
  def self.build_purchase(invoice, params)
    days_until_due_date = invoice.due_date.to_date - Date.today
    amount = invoice.amount * (1 + DAILY_FEE)**days_until_due_date # Check real formula
    Purchase.new(params.merge(
                   { external_id: SecureRandom.uuid,
                     amount: }
                 ))
  end
end
