# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClientsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/clients/1').to route_to('clients#show', external_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/clients').to route_to('clients#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/clients/1').to route_to('clients#update', external_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/clients/1').to route_to('clients#update', external_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/clients/1').to route_to('clients#destroy', external_id: '1')
    end
  end
end
