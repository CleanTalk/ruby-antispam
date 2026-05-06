class Cleantalk
  #
  # Function checks whether it is possible to publish the message
  # @param CleantalkRequest $request
  # @return type
  #
  def is_allowed_message(request)
    request.method_name = 'check_message'
    return request.http_request
  end

  #
  # Function checks whether it is possible to publish the message
  # @param CleantalkRequest $request
  # @return type
  #
  def is_allowed_user(request)
    request.method_name = 'check_newuser'
    return request.http_request
  end

  @@auth_key = nil

  def self.auth_key
    @@auth_key
  end

  def self.auth_key= value
    @@auth_key = value
  end
end

require 'cleantalk/request'
require 'cleantalk/check_newuser'
require 'cleantalk/check_message'
require 'cleantalk/spam_check'
require 'cleantalk/result'
require 'cleantalk/check_newuser_result'
require 'cleantalk/check_message_result'
require 'cleantalk/spam_check_result'