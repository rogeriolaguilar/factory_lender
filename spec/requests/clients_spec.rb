# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/request_helper'

RSpec.describe '/clients', type: :request do
  let(:valid_attributes) do
    { name: 'Name' }
  end

  let(:invalid_attributes) do
    { random: 'Foo' }
  end

  let(:client) do
    create(:client, name: 'Name')
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get "/clients/#{client.external_id}", as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:client_url) { '/clients' }

    context 'with valid parameters' do
      it 'creates a new Client' do
        expect do
          post client_url, params: { client: valid_attributes }, as: :json
        end.to change(Client, :count).by(1)
      end

      it 'renders a JSON response with the new client' do
        post clients_url,
             params: { client: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Client' do
        expect do
          post clients_url,
               params: { client: invalid_attributes }, as: :json
        end.to change(Client, :count).by(0)
      end

      it 'renders a JSON response with errors for the new client' do
        post clients_url,
             params: { client: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    let(:client_url) { "/clients/#{client.external_id}" }

    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'New name' }
      end

      it 'updates the requested client' do
        patch client_url,
              params: { client: new_attributes }, as: :json
        client.reload
        expect(client.name).to eq(new_attributes[:name])
      end

      it 'renders a JSON response with the client' do
        patch client_url,
              params: { client: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(parsed_body(body)).to include(new_attributes)
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the client' do
        patch client_url,
              params: { client: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(parsed_body(body)).to eq(errors: ['invalid params'])
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested client' do
      url = "/clients/#{client.external_id}"
      expect do
        delete url, as: :json
      end.to change(Client, :count).by(-1)
    end
  end
end
