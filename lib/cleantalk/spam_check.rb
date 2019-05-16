require 'net/http'
require 'json'

class Cleantalk::SpamCheck < Cleantalk::Request
  attr_accessor :ip, :email, :date

  def result
    @result ||= Cleantalk::SpamCheckResult.new(http_request_without_parse(SPAMCHECK_API, REQUEST_TYPE))
  end

  def blacklist?(email_or_ip)
    return nil if !self.result.data.empty? && self.result.data[email_or_ip].nil?
    self.result.data[email_or_ip]['appears'] == 1
  end

  SPAMCHECK_API = 'https://api.cleantalk.org'.freeze
  REQUEST_TYPE = 'get'.freeze
  METHOD = 'spam_check'.freeze
end
