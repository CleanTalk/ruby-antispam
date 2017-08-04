# ruby-cleantalk

API to have CleanTalk anti-spam on Ruby

## Install

Install via bundler

    gem 'cleantalk'

## Usage

```ruby
require 'cleantalk'

# Create a request instance
request = Cleantalk::Request.new
request.auth_key        = 'your_key'
request.message         = 'test message' # don't use this field for registration check
request.sender_email    = 'stop_email@example.com
request.sender_nickname = 'test nickname'
request.sender_ip       = '127.0.0.1'
request.js_on           = 1 # you should check for JavaScript by yourself
request.submit_time     = 11 # you should calculate time for submitting form by youself
request.sender_info     = {cms_lang: 'en_US'} # here put locale for your language

cleantalk = Cleantalk.new
result = cleantalk.is_allowed_message(request) # for message checking
result = cleantalk.is_allowed_user(request)    # for registration checking

# result['allow'] contains our decision: 1 for allowed message, 0 for blocked
# result['comment'] contains comment for our decision

# You can also pass auth_key has global configuration:
Cleantalk.auth_key = 'your_default_key'
```
