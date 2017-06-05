require 'spec_helper'

describe Cleantalk::Request do
  it 'create a request' do
    subject.auth_key = 'test'
    expect(subject.auth_key).to eql('test')
  end

  it 'initialize with params' do
    instance = described_class.new({auth_key: 'test', sender_email: 'test@example.org'})
    expect(instance.auth_key).to eql('test')
    expect(instance.sender_email).to eql('test@example.org')
  end
end
