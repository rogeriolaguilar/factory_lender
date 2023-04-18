# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/purchases', type: :request do
  let!(:purchase) { create(:purchase) }
  let(:invoice) { purchase.invoice }
  let(:expected_purchase_body) do
    purchase.as_json.symbolize_keys
            .except(:id)
            .merge({ invoice_id: invoice.external_id, amount: purchase.amount.to_f })
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get "/invoices/#{invoice.external_id}/purchases", as: :json
      expect(response).to be_successful
      expect(parsed_body(response)).to eq([expected_purchase_body])
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get "/purchases/#{purchase.external_id}", as: :json
      expect(response).to be_successful
      expect(parsed_body(response)).to eq(expected_purchase_body)
    end
  end

  describe 'POST /create' do
    let(:purchase_url) { "/purchases/#{purchase.external_id}" }
    context 'with valid parameters' do
      # it 'creates a new Purchase' do
      #   expect do
      #     post purchases_url,
      #          params: { purchase: valid_attributes }, as: :json
      #   end.to change(Purchase, :count).by(1)
      # end

      # it 'renders a JSON response with the new purchase' do
      #   post purchases_url,
      #        params: { purchase: valid_attributes }, as: :json
      #   expect(response).to have_http_status(:created)
      #   expect(response.content_type).to match(a_string_including('application/json'))
      # end
    end

    context 'with invalid parameters' do
      # it 'does not create a new Purchase' do
      #   expect do
      #     post purchases_url,
      #          params: { purchase: invalid_attributes }, as: :json
      #   end.to change(Purchase, :count).by(0)
      # end

      # it 'renders a JSON response with errors for the new purchase' do
      #   post purchases_url,
      #        params: { purchase: invalid_attributes }, as: :json
      #   expect(response).to have_http_status(:unprocessable_entity)
      #   expect(response.content_type).to match(a_string_including('application/json'))
      # end
    end
  end

  describe 'DELETE /destroy' do
    let(:purchase_url) { "/purchases/#{purchase.external_id}" }
    it 'destroys the requested purchase' do
      expect do
        delete purchase_url, as: :json
      end.to change(Purchase, :count).by(-1)
    end
  end
end
