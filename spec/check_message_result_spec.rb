require 'spec_helper'

describe Cleantalk::CheckMessageResult do
  let :clean_init_values do
    {
      "version"         => "7.47",
      "inactive"        => 0,
      "js_disabled"     => 0,
      "blacklisted"     => 1,
      "comment"         => "*** Forbidden. Sender blacklisted. ***",
      "codes"           => "FORBIDDEN BL",
      "fast_submit"     => 0,
      "id"              => "433289e278ae059f8fc58914fc890de2",
      "account_status"  => 1,
      "allow"           => 0,
      "stop_queue"      => 0,
      "spam"            => 1
    }
  end
  let :init_values do
    clean_init_values.merge({
      "lalilulelo"      => "patriot"
    })
  end

  describe "#initialize" do
    it 'pass all result from an Hash' do
      instance = described_class.new(init_values)

      clean_init_values.each do |key, value|
        expect(instance.send(key)).to eql(value)
      end

      expect do
        instance.lalilulelo
      end.to raise_error(NoMethodError)
    end
  end

  it 'pass all result from JSON string' do
    instance = described_class.new(JSON.fast_generate(init_values))

    clean_init_values.each do |key, value|
      expect(instance.send(key)).to eql(value)
    end

    expect do
      instance.lalilulelo
    end.to raise_error(NoMethodError)
  end
end
