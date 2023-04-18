# frozen_string_literal: true

class Client < ApplicationRecord
  validates :name, :external_id, presence: true
  has_many :invoices
end
