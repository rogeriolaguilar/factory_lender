# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  subject do
    build_stubbed(:client)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without name' do
    subject.name = nil
    expect(subject).to be_invalid
  end

  it 'is not valid without external-id' do
    subject.external_id = nil
    expect(subject).to be_invalid
  end
end
