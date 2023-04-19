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
    let(:invoice) { create(:invoice) }
    it 'when invoice does not has purchases' do
      get "/invoices/#{invoice.external_id}/purchases", as: :json
      expect(response).to be_successful
      expect(parsed_body(response)).to eq([])
    end
  end

  describe 'DELETE /destroy' do
    context 'destroys the requested purchase' do
      let(:purchase_url) { "/purchases/#{purchase.external_id}" }
      it do
        expect do
          delete purchase_url, as: :json
        end.to change(Purchase, :count).by(-1)
      end
    end

    context 'purchase do not exists' do
      let(:purchase_url) { "/purchases/#{SecureRandom.uuid}" }
      it do
        expect do
          delete purchase_url, as: :json
        end.to change(Purchase, :count).by(0)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
