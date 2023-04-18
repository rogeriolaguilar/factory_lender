# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Purchase, type: :model do
  subject do
    build(:purchase)
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

    it 'is not valid without invoice reference' do
      subject.invoice = nil
      expect(subject).to be_invalid
    end
  end
end
