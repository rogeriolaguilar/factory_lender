# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceActions do
  subject do
    InvoiceActions.build_invoice(params, client)
  end

  context 'valid params' do
    let(:client) { build(:client) }
    let(:params) do
      { amount: 10.1,
        due_date: '2023-03-03T01:10:01' }
    end

    it { expect(subject.external_id).to be_present }
    it { expect(subject.amount).to eq(params[:amount]) }
    it { expect(subject.due_date).to eq(params[:due_date]) }
    it { expect(subject.status).to eq(Invoice::STATUS_CREATED) }
    it { expect(subject.client).to eq(client) }
  end
end
