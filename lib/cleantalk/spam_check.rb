require 'net/http'
require 'json'

class Cleantalk::SpamCheck < Cleantalk::Request
  attr_accessor :ip, :email, :date

  def result
    @result ||= Cleantalk::SpamCheckResult.new(spam_check_http_request_without_parse)
  end

  def blacklist?(email_or_ip)
    return nil if self.result.data.present? && self.result.data[email_or_ip].nil?
    self.result.data[email_or_ip]['appears'] == 1
  end

  METHOD = 'spam_check'.freeze
end
