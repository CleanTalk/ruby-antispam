require 'spec_helper'

describe Cleantalk::SpamCheck do
  # Testing values
  let :headers do
    {
        'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'Host' => 'api.cleantalk.org'
    }
  end

  let :res_body_spam do
    {"data" =>
         {
             "test@example.org" =>
                 {
                     "appears" => 1,
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
                     "appears" => 1,
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

  let :res_body_not_spam do
    {"data" =>
         {
             "test@example.org" =>
                 {
                     "appears" => 0,
                     "sha256" => '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08',
                     "network_type" => 'hosting',
                     "spam_rate" => '0',
                     "frequency" => '0',
                     "frequency_time_10m" => '0',
                     "frequency_time_1h" => '0',
                     "frequency_time_24h" => '0'
                 },
             "127.0.0.1" =>
                 {
                     "appears" => 0,
                     "sha256" => '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08',
                     "network_type" => 'hosting',
                     "spam_rate" => '0',
                     "frequency" => '0',
                     "frequency_time_10m" => '0',
                     "frequency_time_1h" => '0',
                     "frequency_time_24h" => '0'
                 }
         }
    }
  end

  let :base_parameters do
    {method_name: "spam_check", auth_key: 'test', email: 'test@example.org', ip: '127.0.0.1'}
  end

  let :request do
    described_class.new(base_parameters.merge({method_name: "unknow_method"}))
  end

# Specs
  it 'create a request' do
    subject.auth_key = 'test'
    expect(subject.auth_key).to eql('test')
    expect(subject.is_a? Cleantalk::Request).to eql(true)
    expect(subject.method_name).to eql("spam_check")
  end

  describe "#initialize" do
    it 'can pass params definition' do
      expect(request.auth_key).to eql('test')
      expect(request.email).to eql('test@example.org')
      expect(request.is_a? Cleantalk::Request).to eql(true)
      expect(request.method_name).to eql("spam_check")
      expect(request.ip).to eql(base_parameters[:ip])
    end
  end

  describe "#blacklist?" do
    it "call one time request and return true when blacklisted" do
      stub_request(:get, "https://api.cleantalk.org/?auth_key=test&email=test@example.org&ip=127.0.0.1&method_name=spam_check").
          with(
              headers: {
                  'Accept' => '*/*',
                  'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'Host' => 'api.cleantalk.org',
                  'User-Agent' => 'Ruby'
              }).
          to_return(status: 200, body: JSON.dump(res_body_spam), headers: {})

      expect(request.blacklist?('test@example.org')).to eql(true)
      expect_any_instance_of(described_class).to_not receive(:spam_check_http_request_without_parse)
      expect(request.blacklist?('127.0.0.1')).to eql(true)
      expect(request.blacklist?('randomtext')).to eql(nil)
    end

    it "call one time request and return false when not_blacklisted" do
      stub_request(:get, "https://api.cleantalk.org/?auth_key=test&email=test@example.org&ip=127.0.0.1&method_name=spam_check").
          with(
              headers: {
                  'Accept' => '*/*',
                  'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'Host' => 'api.cleantalk.org',
                  'User-Agent' => 'Ruby'
              }).
          to_return(status: 200, body: JSON.dump(res_body_not_spam), headers: {})

      expect(request.blacklist?('test@example.org')).to eql(false)
      expect_any_instance_of(described_class).to_not receive(:spam_check_http_request_without_parse)
      expect(request.blacklist?('127.0.0.1')).to eql(false)
      expect(request.blacklist?('randomtext')).to eql(nil)
    end
  end
end
