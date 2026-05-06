class Cleantalk::Result
  attr_reader :id, :version, :inactive, :js_disabled, :blacklisted,
              :comment, :codes, :fast_submit, :account_status, :allow,
              :error_no, :error_message

  def initialize body
    body = body.is_a?(String) ? JSON.parse(body) : body
    body.each do |meth, value|
      instance_variable_set("@#{meth}", value) if respond_to? meth
    end
    raise_error?
  end

  private

  def raise_error?
    if send(:error_no).present? || send(:error_message).present?
      raise Cleantalk::Result::ApiErrors, "Error no: #{send(:error_no)}, Error Message: #{send(:error_message)}"
    end
  end

  class Cleantalk::Result::ApiErrors < StandardError; end
end
