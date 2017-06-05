require 'spec_helper'

describe Cleantalk do
  describe '#is_allowed_user' do
    it 'returns the message' do
      response = {
        "version" => "7.47",
        "inactive" => 0,
        "js_disabled => 0,
        'blacklisted" => 1,
        "comment" => "*** Forbidden. Sender blacklisted. ***",
        "codes" => "FORBIDDEN BL",
        "fast_submit" => 0,
        "id" => "5a49267e202169b3a4d9ddefee190065",
        "account_status" => 1,
        "allow" => 0
      }
      stub_request(:post, "https://moderate.cleantalk.org:443/api2.0").
        with(body: "{\"auth_key\":\"your_key\",\"method_name\":\"check_newuser\"}",
             headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'Host'=>'moderate.cleantalk.org', 'User-Agent'=>'Ruby'}).
         to_return(status: 200, body: JSON.dump(response), headers: {})

      request = Cleantalk::Request.new
      request.auth_key = 'your_key'

      expect(subject.is_allowed_user(request)).to eql(response)
    end
  end
end
