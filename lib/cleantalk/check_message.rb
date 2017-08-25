class Cleantalk::CheckMessage < Cleantalk::Request

  def result
    @result ||= Cleantalk::CheckMessageResult.new(http_request_without_parse)
  end

  METHOD = "check_message".freeze
end
