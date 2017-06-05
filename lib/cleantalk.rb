require 'net/http'
require 'json'

class Cleantalk
  class Request
    attr_accessor :all_headers, :last_error_no, :last_error_time, \
                  :last_error_text, :message, :example, :auth_key, :agent, \
                  :stoplist_check, :response_lang, :sender_ip, :sender_email, \
                  :sender_nickname, :sender_info, :post_info, :allow_links, \
                  :submit_time, :js_on, :tz, :feedback, :phone

    # Fill params with constructor
    def initialize(params = nil)
      unless params.nil?
        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end
    end
  end

  #
  # Function checks whether it is possible to publish the message
  # @param CleantalkRequest $request
  # @return type
  #
  def is_allowed_message(request)
    return http_request('check_message', request)
  end

  #
  # Function checks whether it is possible to publish the message
  # @param CleantalkRequest $request
  # @return type
  #
  def is_allowed_user(request)
    return http_request('check_newuser', request)
  end

  def http_request(method_name, request)
    uri = URI 'https://moderate.cleantalk.org/api2.0'
    connection = Net::HTTP.new uri.host, uri.port
    connection.use_ssl = true
    http_request = Net::HTTP::Post.new uri
    form_data = {}
    attrs = request.instance_variables
    attrs.each {|elem| form_data[elem.to_s.sub('@','')] = request.instance_variable_get(elem) }
    form_data['method_name'] = method_name

    req = Net::HTTP::Post.new(uri, {'Content-Type' =>'application/json'})
    req.body = form_data.to_json
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    return JSON.parse(response.entity)
  end
end
