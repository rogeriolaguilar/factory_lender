# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurchaseActions do
  describe 'build_purchase' do
    let(:fee_strategy) { Fees::DefaultFeeStrategy.new }
    subject do
      PurchaseActions.build_purchase(invoice, fee_strategy)
    end

    context 'valid params' do
      before do
        allow(fee_strategy).to receive(:accrue_fee).with(invoice.amount, 1).and_return(amount_after_accrue_fees)
      end
      let(:invoice) { build_stubbed(:invoice, amount: 1000, due_date: Date.tomorrow) }
      let(:amount_after_accrue_fees) { 900 }

      it { expect(subject.amount).to eq(amount_after_accrue_fees) }
      it { expect(subject.external_id).to be_present }
      it { expect(subject.invoice).to eq(invoice) }
    end
  end
end
