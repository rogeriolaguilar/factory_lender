# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurchasesController, type: :routing do
  describe 'routing' do
    let(:invoice_external_id) { SecureRandom.uuid }
    let(:external_id) { SecureRandom.uuid }

    it 'routes to #index' do
      expect(get: "/invoices/#{invoice_external_id}/purchases").to route_to('purchases#index', { invoice_external_id: })
    end

    it 'routes to #show' do
      expect(get: "/purchases/#{external_id}").to route_to('purchases#show', { external_id: })
    end

    it 'routes to #destroy' do
      expect(delete: "/purchases/#{external_id}").to route_to('purchases#destroy', { external_id: })
    end
  end
end
