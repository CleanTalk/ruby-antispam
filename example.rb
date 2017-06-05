require './cleantalk.class.rb'

sender_info = {cms_lang:'en_US'} #here put locale for your language
request = Cleantalk::Request.new
request.auth_key = 'your_key'
request.message = 'test message' #don't use this field for registration check
request.sender_email = 'stop_email@example.com'
request.sender_nickname = 'test nickname'
request.sender_ip = '127.0.0.1'
request.js_on = 1 #you should check for JavaScript by yourself
request.submit_time = 11 # you should calculate time for submitting form by youself
request.sender_info = sender_info

ct = Cleantalk.new
result = ct.is_allowed_message?(request) # for message checking
#result = ct.is_allowed_user?(request) # for registration checking
puts result
