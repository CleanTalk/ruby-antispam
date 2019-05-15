require 'net/http'
require 'json'

class Cleantalk::SpamCheck < Cleantalk::Request
  attr_accessor :ip, :email, :date

  def result
    @result ||= Cleantalk::SpamCheckResult.new(spam_check_http_request_without_parse)
  end

  def spammed?
    self.result.appears == 1
  end

  METHOD = 'spam_check'.freeze
end
