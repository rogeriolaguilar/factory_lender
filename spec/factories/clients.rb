# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { 'Client' }
    external_id { SecureRandom.uuid }
  end
end
