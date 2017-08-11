require 'spec_helper'

describe Cleantalk::CheckNewuser do
  # Testing values
  let :headers do
    {
      'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'Host'=>'moderate.cleantalk.org'
    }
  end

  let :res_body_ban do
    {
      "version"         => "7.47",
      "inactive"        => 0,
      "js_disabled"     => 0,
      "blacklisted"     => 1,
      "comment"         => "*** Forbidden. Sender blacklisted. ***",
      "codes"           => "FORBIDDEN BL",
      "fast_submit"     => 0,
      "id"              => "5a49267e202169b3a4d9ddefee190065",
      "account_status"  => 1,
      "allow"           => 0
    }
  end

  let :res_body_not_ban do
    {
      "version"         => "7.47",
      "inactive"        => 0,
      "js_disabled"     => 0,
      "blacklisted"     => 0,
      "comment"         => "",
      "codes"           => "",
      "fast_submit"     => 0,
      "id"              => "5a49267e202169b3a4d9ddefee190065",
      "account_status"  => 1,
      "allow"           => 1
    }
  end

  let :base_parameters do
    { method_name: "check_newuser", auth_key: 'test', sender_email: 'test@example.org' }
  end

  let :request do
    described_class.new(base_parameters.merge({method_name: "unknow_method"}))
  end

  # Specs
  it 'create a request' do
    subject.auth_key = 'test'
    expect(subject.auth_key).to eql('test')
    expect(subject.is_a? Cleantalk::Request).to eql(true)
    expect(subject.method_name).to eql("check_newuser")
  end

  describe "#initialize" do
    it 'can pass params definition' do
      expect(request.auth_key).to eql('test')
      expect(request.sender_email).to eql('test@example.org')
      expect(subject.is_a? Cleantalk::Request).to eql(true)
      expect(subject.method_name).to eql("check_newuser")
    end
  end

  describe "#allowed?" do
    it "call one time request and return false when not allowed" do
      stub_request(:post, "https://moderate.cleantalk.org:443/api2.0").with(body: JSON.fast_generate(base_parameters), headers: headers).to_return(status: 200, body: JSON.dump(res_body_ban), headers: {})

      expect(request.allowed?).to eql(false)
      expect_any_instance_of(described_class).to_not receive(:http_request_without_parse)
      expect(request.allowed?).to eql(false)
      expect(request.allowed?).to eql(false)
    end

    it "call one time request and return false when not allowed" do
      stub_request(:post, "https://moderate.cleantalk.org:443/api2.0").with(body: JSON.fast_generate(base_parameters), headers: headers).to_return(status: 200, body: JSON.dump(res_body_not_ban), headers: {})

      expect(request.allowed?).to eql(true)
      expect_any_instance_of(described_class).to_not receive(:http_request_without_parse)
      expect(request.allowed?).to eql(true)
      expect(request.allowed?).to eql(true)
    end
  end
end
