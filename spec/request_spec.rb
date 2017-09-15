require 'spec_helper'

describe Cleantalk::Request do
  # Testing values
  let :headers do
    {
      'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'Host'=>'moderate.cleantalk.org'
    }
  end

  let :base_parameters do
    { method_name: "check_message", auth_key: 'test', sender_email: 'test@example.org' }
  end

  let :request do
    described_class.new(base_parameters)
  end

  # Specs
  it 'create a request' do
    subject.auth_key = 'test'
    expect(subject.auth_key).to eql('test')
  end

  describe "#initialize" do
    it 'can pass params definition' do
      expect(request.auth_key).to eql('test')
      expect(request.sender_email).to eql('test@example.org')
    end
  end

  describe "#http_request" do
    it "call api with parameters based on Request attributes and return request body" do
      response, body = {"ok" => true}, JSON.fast_generate(base_parameters)

      stub_request(:post, "https://moderate.cleantalk.org:443/api2.0").
        with(body: body, headers: headers).
        to_return(status: 200, body: JSON.dump(response), headers: {})

      expect(request.http_request).to eql(response)
    end

    it "raise an Exception when a required params is nil" do
      expect do
        subject.http_request
      end.to raise_error(Cleantalk::Request::BadParameters)
    end

    it "can use global conf auth_key" do
      Cleantalk.auth_key = 'global_test'

      response, body = {"ok" => true}, JSON.fast_generate(base_parameters.dup.merge({auth_key: Cleantalk.auth_key}))
      base_parameters.delete(:auth_key)
      request

      stub_request(:post, "https://moderate.cleantalk.org:443/api2.0").
        with(body: body, headers: headers).
        to_return(status: 200, body: JSON.dump(response), headers: {})

      expect(request.http_request).to eql(response)
    end
  end
end
