# ruby-cleantalk

API to have CleanTalk anti-spam on Ruby

## Install

Install via bundler

    gem 'cleantalk'

For improve protection include javascript to your layout before </body> tag:
```html
<script type="text/javascript" src="https://moderate.cleantalk.org/ct-bot-detector-wrapper.js"></script>
```

## Usage

```ruby
require 'cleantalk'

# Create a check_newuser request
request = Cleantalk::CheckNewuser.new({ auth_key: 'ur_api_key', sender_email: 'test@example.org' }) # Can initialize with values
request.sender_ip       = '127.0.0.1' # and also mutate object directly
request.sender_nickname = 'test nickname'

request.allowed? # => true or false
request.result   # => <Object Cleantalk::CheckNewuserResult> with all response data

# Create a check_message request
request = Cleantalk::CheckMessage.new({
  auth_key: 'ur_api_key', sender_email: 'test@example.org',
  sender_ip: '127.0.0.1', sender_nickname: 'test nickname',
}) # Can initialize with values
request.message = '<p>Hello World!</p>'  # and also mutate object directly

request.allowed? # => true or false
request.result   # => <Object Cleantalk::CheckMessageResult> with all response data

# You can also pass auth_key has global configuration (still overridable by passing auth_key to request):
Cleantalk.auth_key = 'ur_api_key'

# Create a legacy request instance
request = Cleantalk::Request.new
request.auth_key        = 'your_key'
request.message         = 'test message' # don't use this field for registration check
request.sender_email    = 'stop_email@example.com'
request.sender_nickname = 'test nickname'
request.sender_ip       = '127.0.0.1'
request.sender_info     = {cms_lang: 'en_US'} # here put locale for your language

# In case use js bot detector, add event_token from your form for check frontend data
# request.event_token     = 'xxx' # fill it with ct_bot_detector_event_token hidden input from your form (auto generate)

cleantalk = Cleantalk.new
result = cleantalk.is_allowed_message(request) # for message checking
result = cleantalk.is_allowed_user(request)    # for registration checking

# result['allow'] contains our decision: 1 for allowed message, 0 for blocked
# result['comment'] contains comment for our decision
```
## Requirements

* CleanTalk account https://cleantalk.org/register?product=anti-spam