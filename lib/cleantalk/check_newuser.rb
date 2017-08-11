class Cleantalk::CheckNewuser < Cleantalk::Request
  attr_reader :result

  def initialize *args
    super *args
    self.method_name = METHOD
  end

  def allowed?
    @result ||= Cleantalk::CheckNewuserResult.new(http_request_without_parse)
    @result.allow == 1
  end

  def method_name= *args
    @method_name = METHOD
  end

  METHOD = "check_newuser".freeze
end
