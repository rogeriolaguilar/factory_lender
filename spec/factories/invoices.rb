# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    external_id { SecureRandom.uuid }
    amount { 10.1 }
    due_date { DateTime.tomorrow }
    status { Invoice::STATUS_CREATED }
    client
  end
end
