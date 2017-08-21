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
  def initialize(params = nil)
    unless params.nil?
      params.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end

  # Remote Call
  def http_request
    form_data, attrs = {}, self.instance_variables
    attrs.each {|elem| form_data[elem.to_s.sub('@','')] = self.instance_variable_get(elem) }

    req = Net::HTTP::Post.new(API_URI, {'Content-Type' =>'application/json'})
    req.body = form_data.to_json
    response = Net::HTTP.start(API_URI.hostname, API_URI.port, use_ssl: true) do |http|
      http.request(req)
    end
    return JSON.parse(response.entity)
  end

  API_URI = URI.parse('https://moderate.cleantalk.org/api2.0').freeze
end
