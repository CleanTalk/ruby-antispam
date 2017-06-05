require 'net/http'
require 'json'

class Cleantalk
  class Request
    attr_accessor :all_headers, :last_error_no, :last_error_time, :last_error_text, :message, :example, :auth_key, :agent, :stoplist_check, :response_lang, :sender_ip, :sender_email, :sender_nickname, :sender_info, :post_info, :allow_links, :submit_time, :js_on, :tz, :feedback, :phone

    #
    #  All http request headers
    # @var string
    #
    @all_headers = nil;

    #
    #  Last error number
    # @var integer
    #
    @last_error_no = nil;

    #
    #  Last error time
    # @var integer
    #
    @last_error_time = nil;

    #
    #  Last error text
    # @var string
    #
    @last_error_text = nil;

    #
    # User message
    # @var string
    #
    @message = nil;

    #
    # Post example with last comments
    # @var string
    #
    @example = nil;

    #
    # Auth key
    # @var string
    #
    @auth_key = nil;

    #
    # Engine
    # @var string
    #
    @agent = nil;

    #
    # Is check for stoplist,
    # valid are 0|1
    # @var int
    #
    @stoplist_check = nil;

    #
    # Language server response,
    # valid are 'en' or 'ru'
    # @var string
    #
    @response_lang = nil;

    #
    # User IP
    # @var strings
    #
    @sender_ip = nil;

    #
    # User email
    # @var strings
    #
    @sender_email = nil;

    #
    # User nickname
    # @var string
    #
    @sender_nickname = nil;

    #
    # Sender info JSON string
    # @var hash
    #
    @sender_info = nil;

    #
    # Post info JSON string
    # @var string
    #
    @post_info = nil;

    #
    # Is allow links, email and icq,
    # valid are 1|0
    # @var int
    #
    @allow_links = nil;

    #
    # Time form filling
    # @var int
    #
    @submit_time = nil;

    #
    # Is enable Java Script,
    # valid are 0|1
    # Status:
    #  nil - JS html code not inserted into phpBB templates
    #  0 - JS disabled at the client browser
    #  1 - JS enabled at the client broswer
    # @var int
    #
    @js_on = 0;

    #
    # user time zone
    # @var string
    #
    @tz = nil;

    #
    # Feedback string,
    # valid are 'requset_id:(1|0)'
    # @var string
    #
    @feedback = nil;

    #
    # Phone number
    # @var type
    #
    @phone = nil;

    #
    # Fill params with constructor
    # @param type $params
    #
    def initialize(params = nil)
      if (params!=nil && params.length>0)
        params.each_index{|elem|@elem = params.at(elem)}
      end
    end
  end

  #
  # Function checks whether it is possible to publish the message
  # @param CleantalkRequest $request
  # @return type
  #
  def is_allowed_message?(request)
    return http_request('check_message',request)
  end

  #
  # Function checks whether it is possible to publish the message
  # @param CleantalkRequest $request
  # @return type
  #
  def is_allowed_user?(request)
    return http_request('check_newuser',request)
  end

  def http_request(method_name, request)
    uri = URI 'https://moderate.cleantalk.org/api2.0'
    connection = Net::HTTP.new uri.host, uri.port
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
