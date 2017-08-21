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
end

require 'cleantalk/request'
