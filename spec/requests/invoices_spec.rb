# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/invoices', type: :request do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Invoice.create! valid_attributes
      get invoices_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      invoice = Invoice.create! valid_attributes
      get invoice_url(invoice), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Invoice' do
        expect do
          post invoices_url,
               params: { invoice: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Invoice, :count).by(1)
      end

      it 'renders a JSON response with the new invoice' do
        post invoices_url,
             params: { invoice: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Invoice' do
        expect do
          post invoices_url,
               params: { invoice: invalid_attributes }, as: :json
        end.to change(Invoice, :count).by(0)
      end

      it 'renders a JSON response with errors for the new invoice' do
        post invoices_url,
             params: { invoice: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested invoice' do
        invoice = Invoice.create! valid_attributes
        patch invoice_url(invoice),
              params: { invoice: new_attributes }, headers: valid_headers, as: :json
        invoice.reload
        skip('Add assertions for updated state')
      end

      it 'renders a JSON response with the invoice' do
        invoice = Invoice.create! valid_attributes
        patch invoice_url(invoice),
              params: { invoice: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the invoice' do
        invoice = Invoice.create! valid_attributes
        patch invoice_url(invoice),
              params: { invoice: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested invoice' do
      invoice = Invoice.create! valid_attributes
      expect do
        delete invoice_url(invoice), headers: valid_headers, as: :json
      end.to change(Invoice, :count).by(-1)
    end
  end
end
