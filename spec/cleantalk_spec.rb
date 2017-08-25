require 'spec_helper'

describe Cleantalk do
  let :headers do
    {
      'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'Host'=>'moderate.cleantalk.org'
    }
  end

  describe '#is_allowed_user' do
    it 'return the response body' do
      response = {
        "version"        => "7.47",
        "inactive"       => 0,
        "js_disabled"    => 0,
        "blacklisted"    => 1,
        "comment"        => "*** Forbidden. Sender blacklisted. ***",
        "codes"          => "FORBIDDEN BL",
        "fast_submit"    => 0,
        "id"             => "5a49267e202169b3a4d9ddefee190065",
        "account_status" => 1,
        "allow"          => 0
      }

      body = JSON.fast_generate({
        method_name: "check_newuser", auth_key: "your_key"
      })

      stub_request(:post, "https://moderate.cleantalk.org:443/api2.0").
        with(body: body, headers: headers).
        to_return(status: 200, body: JSON.dump(response), headers: {})

      request = Cleantalk::Request.new
      request.auth_key = 'your_key'

      expect(subject.is_allowed_user(request)).to eql(response)
    end
  end

  describe '#is_allowed_message' do
    it 'return the response body' do
      response = {
        "stop_queue"     => 0,
        "inactive"       => 0,
        "version"        => "7.47",
        "spam"           => 1,
        "js_disabled"    => 0,
        "comment"        => "*** Forbidden. Sender blacklisted. ***",
        "codes"          => "FORBIDDEN BL",
        "blacklisted"    => 1,
        "fast_submit"    => 0,
        "account_status" => "1",
        "id"             => "433289e278ae059f8fc58914fc890de2",
        "allow"          => 0
      }

      body = JSON.fast_generate({
        method_name: "check_message", auth_key: "your_key"
      })

      stub_request(:post, "https://moderate.cleantalk.org:443/api2.0").
        with(body: body, headers: headers).
        to_return(status: 200, body: JSON.dump(response), headers: {})

      request = Cleantalk::Request.new
      request.auth_key = 'your_key'

      expect(subject.is_allowed_message(request)).to eql(response)
    end
  end
end
