# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoicesController, type: :routing do
  let(:client_external_id) { SecureRandom.uuid }
  let(:external_id) { SecureRandom.uuid }
  describe 'routing' do
    it 'routes to #index' do
      expect(get: "clients/#{client_external_id}/invoices/").to route_to('invoices#index', { client_external_id: })
    end

    it 'routes to #show' do
      expect(get: "clients/#{client_external_id}/invoices/#{external_id}")
        .to route_to('invoices#show', { external_id:, client_external_id: })
    end

    it 'routes to #create' do
      expect(post: "clients/#{client_external_id}/invoices")
        .to route_to('invoices#create', { client_external_id: })
    end

    it 'routes to #update via PUT' do
      expect(put: "clients/#{client_external_id}/invoices/#{external_id}")
        .to route_to('invoices#update', { external_id:, client_external_id: })
    end

    it 'routes to #update via PATCH' do
      expect(patch: "clients/#{client_external_id}/invoices/#{external_id}")
        .to route_to('invoices#update', { external_id:, client_external_id: })
    end

    it 'routes to #destroy' do
      expect(delete: "clients/#{client_external_id}/invoices/#{external_id}")
        .to route_to('invoices#destroy', { external_id:, client_external_id: })
    end
  end
end
