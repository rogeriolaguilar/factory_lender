# frozen_string_literal: true

class Invoice < ApplicationRecord
  STATUS_CREATED = 'created'
  STATUS_APPROVED = 'approved'
  STATUS_REJECTED = 'rejected'
  STATUS_PURCHASED = 'purchased'
  STATUS_CLOSED = 'closed'
  STATUSES = [STATUS_CREATED, STATUS_APPROVED, STATUS_REJECTED, STATUS_PURCHASED, STATUS_CLOSED].freeze

  NEXT_STATUS_MAP = {
    Invoice::STATUS_CREATED => [Invoice::STATUS_APPROVED, Invoice::STATUS_REJECTED],
    Invoice::STATUS_APPROVED => [Invoice::STATUS_PURCHASED],
    Invoice::STATUS_PURCHASED => [Invoice::STATUS_CLOSED],
    Invoice::STATUS_CLOSED => [],
    Invoice::STATUS_REJECTED => []
  }.freeze

  validates :status, :due_date, :amount, :client, :external_id, :document_url, presence: true
  validates :status, inclusion: { in: STATUSES, message: '%<value> is not a valid status' }
  validates :amount, numericality: true
  validates :document_url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'must be a url' }

  belongs_to :client
  has_many :purchases
end
