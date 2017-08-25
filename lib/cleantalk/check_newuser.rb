class Cleantalk::CheckNewuser < Cleantalk::Request
  def result
    @result ||= Cleantalk::CheckNewuserResult.new(http_request_without_parse)
  end

  METHOD = "check_newuser".freeze
end
