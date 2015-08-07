

class CleantalkResponse {

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

			@errstr = @errstr.gsub(/.+(\*\*\*.+\*\*\*).+/, \1, @errstr)

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

            if (@errno !== 0 && @errstr !== nil && @comment === nil)
                @comment = '*** ' + @errstr + ' Antispam service cleantalk.org ***' 
        end
    end
end