# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurchaseActions do
  describe 'build_purchase' do
    subject do
      PurchaseActions.build_purchase(invoice)
    end

    context 'valid params' do
      let(:invoice) { build_stubbed(:invoice) }

      it { expect(subject.amount).to be <= invoice.amount }
      it { expect(subject.external_id).to be_present }
      it { expect(subject.invoice).to eq(invoice) }
    end
  end
end
