class Cleantalk::CheckNewuser < Cleantalk::Request
  attr_accessor :event_token

  def result
    @result ||= Cleantalk::CheckNewuserResult.new(http_request_without_parse)
  end

  METHOD = "check_newuser".freeze
end
