require 'net/http'
require 'json'

class Cleantalk::Request
  attr_accessor :method_name, :auth_key, #required
                :all_headers, :last_error_no, :last_error_time,
                :last_error_text, :message, :example, :agent,
                :stoplist_check, :response_lang, :sender_ip, :sender_email,
                :sender_nickname, :sender_info, :post_info, :allow_links,
                :submit_time, :js_on, :tz, :feedback, :phone

  # Fill params with constructor
  def initialize(params = {})
    self.method_name = params.delete(:method_name) || self.class::METHOD
    unless params.empty?
      params.each do |key, value|
        send("#{key}=", value)
      end
    end
  end

  def http_request_without_parse
    valid?
    form_data = self.instance_variables.inject({}) do |params, var_name|
      param_key = var_name.to_s.sub('@','')
      params[param_key] = send(param_key)
      params
    end

    req = Net::HTTP::Post.new(API_URI, API_HEADERS)
    req.body = JSON.generate(form_data)
    response = Net::HTTP.start(API_URI.hostname, API_URI.port, use_ssl: true) do |http|
      http.request(req)
    end

    response.entity
  end

  # Remote Call
  def http_request
    JSON.parse http_request_without_parse
  end

  def auth_key
    @auth_key || Cleantalk.auth_key
  end

  def method_name= value
    @method_name = self.class::METHOD || value
  end

  def result
    @result ||= http_request
  end

  def allowed?
    self.result.allow == 1
  end

  private

  def valid?
    [:auth_key, :method_name].freeze.each do |required_param|
      raise Cleantalk::Request::BadParameters, "params `#{required_param}` is required for #{self.class}" if send(required_param).nil?
    end
  end

  API_URI = URI.parse('https://moderate.cleantalk.org/api2.0').freeze
  API_HEADERS = {'Content-Type' =>'application/json'}.freeze
  METHOD = nil
  class Cleantalk::Request::BadParameters < StandardError; end
end
