# frozen_string_literal: true

class Purchase < ApplicationRecord
  validates :invoice, :amount, :external_id, presence: true
  validates :amount, numericality: true
  belongs_to :invoice
end
