require 'net/http'
require 'json'

class CleantalkResponse

    #
    # Is stop words
    #@var int
    #
    @stop_words = nil
    
    #
    #Cleantalk comment
    #@var string
    #
    @comment = nil

    #
    #Is blacklisted
    #@var int
    #
    @blacklisted = nil

    #
    #Is allow, 1|0
    #@var int
    #
    @allow = nil

    #
    #Request ID
    #@var int
    #
    @id = nil

    #
    #Request errno
    #@var int
    #
    @errno = nil

    #
    #Error string
    #@var string
    #
    @errstr = nil

    #
    #Is fast submit, 1|0
    #@var string
    #
    @fast_submit = nil

    #
    #Is spam comment
    #@var string
    #
    @spam = nil

    #
    #Is JS
    #@var type 
    #
    @js_disabled = nil

    #
    #Stop queue message, 1|0
    #@var int  
    #
    @stop_queue = nil
    
    #
    #Account shuld by deactivated after registration, 1|0
    #@var int  
    #
    @inactive = nil

    #
    #Account status 
    #@var int  
    #
    @account_status = -1

    #
    #Create server response
    #@param type response
    #@param type obj
    #
    def initialize(response = nil, obl = nil)
        if (response.length > 0)
            response.each_index{|elem|@elem = response.at(elem)}
        else
            @errno = obj.errno
            @errstr = obj.errstr

            #@errstr = @errstr.gsub(/.+(\*\*\*.+\*\*\*).+/, \1, @errstr)

            obj.stop_words.empty ? @stop_words = obj.stop_words : @stop_words = nil
            obj.comment.empty ? @comment = obj.comment : @comment  = nil
            obj.blacklisted.empty ? @blacklisted = obj.blacklisted : @blacklisted = nil
            obj.allow.empty ? @allow = obj.allow : @allow = 0
            obj.id.empty ? @id = obj.id : @id = nil
            obj.fast_submit.empty ? @fast_submit = obj.fast_submit : @fast_submit = 0
            obj.spam.empty ? @spam = obj.spam : @spam = 0
            obj.js_disabled.empty ? @js_disabled = obj.js_disabled : @js_disabled = 0
            obj.stop_queue.empty ? @stop_queue = obj.stop_queue : @stop_queue = 0
            obj.inactive.empty ? @inactive = obj.inactive : @inactive = 0
            obj.account_status.empty ? @account_status = obj.account_status : @account_status = -1

            if (@errno != 0 && @errstr != nil && @comment == nil)
                @comment = '*** ' + @errstr + ' Antispam service cleantalk.org #**' 
            end
        end
    end
end


 #
 # Request class
 # 
class CleantalkRequest
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
 # Cleantalk class create request
 #
class Cleantalk

     #
     # Debug level
     # @var int
     #
     @debug = 0;
    
     #
     # Server connection timeout in seconds 
     # @var int
     #
     @server_timeout = 3;

     #
     # Cleantalk server url
     # @var string
     #
     @server_url = nil;

     #
     # Last work url
     # @var string
     #
     @work_url = nil;

     #
     # WOrk url ttl
     # @var int
     #
     @server_ttl = nil;

     #
     # Time wotk_url changer
     # @var int
     #
     @server_changed = nil;

     #
     # Flag is change server url
     # @var bool
     #
     @server_change = false;

     #
     # Codepage of the data 
     # @var bool
     #
     @data_codepage = nil;
    
     #
     # API version to use 
     # @var string
     #
     @api_version = '/api2.0';
    
     #
     # Use https connection to servers 
     # @var bool 
     #
     @ssl_on = false;

     #
     # Minimal server response in miliseconds to catch the server
     #
     #
     @min_server_timeout = 50;

     #
     # Function checks whether it is possible to publish the message
     # @param CleantalkRequest $request
     # @return type
     #
    def isAllowMessage(request)
        return httpRequest('check_message',request)
    end

    #
    # Function checks whether it is possible to publish the message
    # @param CleantalkRequest $request
    # @return type
    #
    def isAllowUser(request)        
        return httpRequest('check_newuser',request)
    end
    
    def httpRequest(method_name, request)
    	uri = URI 'http://moderate.cleantalk.org/api2.0'
        connection = Net::HTTP.new uri.host, uri.port
        http_request = Net::HTTP::Post.new uri
        form_data={}
        attrs=request.instance_variables
        attrs.each{|elem|form_data[elem.to_s.sub('@','')] = request.instance_variable_get(elem)}
        form_data['method_name'] = method_name

		req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'application/json'})
		req.body = form_data.to_json
		response = Net::HTTP.start(uri.hostname, uri.port) do |http|
		  http.request(req)
		end
        return JSON.parse(response.entity)
    end
end
