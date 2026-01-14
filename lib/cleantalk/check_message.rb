class Cleantalk::CheckMessage < Cleantalk::Request
  attr_accessor :event_token

  attr_accessor :message

  def result
    @result ||= Cleantalk::CheckMessageResult.new(http_request_without_parse)
  end

  METHOD = "check_message".freeze
end
