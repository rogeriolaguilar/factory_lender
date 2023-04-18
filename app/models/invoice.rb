# frozen_string_literal: true

class Invoice < ApplicationRecord
  STATUS_CREATED = 'created'
  STATUSES = %w[created approved rejected purchased closed].freeze

  validates :status, :due_date, :amount, :client, :external_id, presence: true
  validates :status, inclusion: { in: STATUSES, message: '%<value> is not a valid status' }
  validates :amount, numericality: true

  belongs_to :client
end
