# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceActions do
  describe 'build_invoice' do
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

  describe 'update_invoice' do
    subject do
      InvoiceActions.update_invoice(invoice, params)
    end
    let(:invoice) { build(:invoice) }

    context 'valid params' do
      let(:params) do
        { amount: rand(1000.1...10_000.9),
          due_date: '2024-04-04T04:04:04' }
      end

      it { expect(subject.amount).to eq(params[:amount]) }
      it { expect(subject.due_date).to eq(params[:due_date]) }
      it { expect(subject.status).to eq(invoice.status) }
      it { expect(subject.client).to eq(invoice.client) }
    end

    context 'change status' do
      let(:invoice) { build(:invoice, status: initial_status) }

      context 'from created to approved' do
        let(:initial_status) { Invoice::STATUS_CREATED }
        let(:params) { { status: Invoice::STATUS_APPROVED } }
        it { expect(subject.status).to eq(Invoice::STATUS_APPROVED) }
      end

      context 'from created to rejected' do
        let(:initial_status) { Invoice::STATUS_CREATED }
        let(:params) { { status: Invoice::STATUS_REJECTED } }
        it { expect(subject.status).to eq(Invoice::STATUS_REJECTED) }
      end

      context 'from created to approved' do
        let(:initial_status) { Invoice::STATUS_CREATED }
        let(:params) { { status: Invoice::STATUS_APPROVED } }
        it { expect(subject.status).to eq(Invoice::STATUS_APPROVED) }
      end

      context 'from created to approved' do
        let(:initial_status) { Invoice::STATUS_CREATED }
        let(:params) { { status: Invoice::STATUS_CLOSED } }
        it { expect { subject }.to raise_error(Errors::WrongInvoiceStatusError) }
      end

      context 'from closed to approved' do
        let(:initial_status) { Invoice::STATUS_CLOSED }
        let(:params) { { status: Invoice::STATUS_APPROVED } }
        it { expect { subject }.to raise_error(Errors::WrongInvoiceStatusError) }
      end
    end
  end
end
