# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
    external_id { SecureRandom.uuid }
    amount { rand(10.99...1000.0) }
    invoice
  end
end
