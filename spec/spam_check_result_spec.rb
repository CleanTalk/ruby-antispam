require 'spec_helper'

describe Cleantalk::SpamCheckResult do
  let :clean_init_values do
    {"data" =>
         {
             "test@example.org" =>
                 {
                     "appears" => 0,
                     "sha256" => '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08',
                     "network_type" => 'public',
                     "spam_rate" => '3',
                     "frequency" => '5',
                     "frequency_time_10m" => '1',
                     "frequency_time_1h" => '2',
                     "frequency_time_24h" => '4'
                 },
             "127.0.0.1" =>
                 {
                     "appears" => 0,
                     "sha256" => '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08',
                     "network_type" => 'hosting',
                     "spam_rate" => '4',
                     "frequency" => '1',
                     "frequency_time_10m" => '3',
                     "frequency_time_1h" => '2',
                     "frequency_time_24h" => '1'
                 }
         }

    }
  end
  let :init_values do
    clean_init_values.merge({
                                "lalilulelo" => "patriot"
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
