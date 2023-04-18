# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/invoices', type: :request do
  let!(:invoice) { create(:invoice) }
  let(:client_external_id) { invoice.client.external_id }
  let(:expected_invoice_body) do
    invoice.as_json.symbolize_keys
           .except(:id)
           .merge({ client_id: client_external_id, amount: invoice.amount.to_f })
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get "/clients/#{client_external_id}/invoices", as: :json
      expect(response).to be_successful
      expect(parsed_body(response)).to eq([expected_invoice_body])
    end

    it 'renders not found if client do not exists' do
      get "/clients/#{SecureRandom.uuid}/invoices", as: :json
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get "/clients/#{client_external_id}/invoices/#{invoice.external_id}", as: :json
      expect(response).to be_successful
      expect(parsed_body(response)).to eq(expected_invoice_body)
    end
  end

  describe 'POST /create' do
    let(:create_attributes) do
      { status: Invoice::STATUS_CREATED,
        amount: 1000.0,
        due_date: '2030-02-03T00:00:00.000Z' }
    end

    context 'with valid parameters' do
      it 'creates a new Invoice' do
        expect do
          post "/clients/#{client_external_id}/invoices", params: { invoice: create_attributes }, as: :json
        end.to change(Invoice, :count).by(1)
      end

      it 'renders a JSON response with the new invoice' do
        post "/clients/#{client_external_id}/invoices", params: { invoice: create_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(parsed_body(response)).to include(create_attributes)
      end
    end

    context 'with invalid parameters' do
      let(:post_url) { "/clients/#{client_external_id}/invoices" }
      let(:invalid_params) do
        { amount: '2020-12-12' }
      end
      it 'does not create a new Invoice' do
        expect do
          post post_url, params: { invoice: invalid_params }, as: :json
        end.to change(Invoice, :count).by(0)
      end

      it 'renders a JSON response with errors for the new invoice' do
        post post_url,
             params: { invoice: invalid_params }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    let(:url) { "/clients/#{client_external_id}/invoices/#{invoice.external_id}" }
    context 'with valid parameters' do
      let(:new_attributes) do
        { amount: 987.12, due_date: DateTime.tomorrow }
      end

      it 'updates the requested invoice' do
        patch url,
              params: { invoice: new_attributes }, as: :json
        invoice.reload
        expect(invoice.amount).to eq(new_attributes[:amount])
        expect(invoice.due_date).to eq(new_attributes[:due_date])
      end

      it 'renders a JSON response with the invoice' do
        patch url,
              params: { invoice: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the invoice' do
        invalid_attributes = { amount: '2020-12-12' }
        patch url,
              params: { invoice: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PUT /change_status' do
    let!(:invoice) { create(:invoice, status: Invoice::STATUS_CREATED) }
    context 'with invalid next status' do
      it 'renders a JSON response with errors for the invoice' do
        put "/invoices/#{invoice.external_id}/change_status",
            params: { status: Invoice::STATUS_APPROVED }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
        invoice.reload
        expect(invoice.status).to eq(Invoice::STATUS_APPROVED)
      end
    end

    context 'with invalid next status' do
      it 'renders a JSON response with errors for the invoice' do
        put "/invoices/#{invoice.external_id}/change_status",
            params: { status: Invoice::STATUS_CLOSED }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested invoice' do
      expect do
        delete "/clients/#{client_external_id}/invoices/#{invoice.external_id}", as: :json
      end.to change(Invoice, :count).by(-1)
    end
  end
end
