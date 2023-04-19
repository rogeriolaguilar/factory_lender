# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'test attributes validation' do
    subject do
      build(:invoice)
    end

    context 'attributes validation' do
      it 'is valid with valid attributes' do
        expect(subject).to be_valid
      end

      it 'is not valid without external_id' do
        subject.external_id = nil
        expect(subject).to be_invalid
      end

      it 'is not valid with blank external_id' do
        subject.external_id = ''
        expect(subject).to be_invalid
      end

      it 'is not valid without external_id' do
        subject.amount = nil
        expect(subject).to be_invalid
      end

      it 'is not valid with invalid amount' do
        subject.amount = 'Foo'
        expect(subject).to be_invalid
      end

      it 'is not valid without due_date' do
        subject.due_date = nil
        expect(subject).to be_invalid
      end

      it 'is not valid without client' do
        subject.client = nil
        expect(subject).to be_invalid
      end

      it 'is not valid without status' do
        subject.status = nil
        expect(subject).to be_invalid
      end

      it 'is not valid with invalid status' do
        subject.status = 'random'
        expect(subject).to be_invalid
      end
    end
  end

  describe 'purchases' do
    describe 'invoice has purchases' do
      subject { create(:purchase).invoice }
      it { expect(subject.purchases.first).to be_instance_of(Purchase) }
    end
  end
end
