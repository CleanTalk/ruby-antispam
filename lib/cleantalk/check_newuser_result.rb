class Cleantalk::CheckNewuserResult
  attr_reader :id, :version, :inactive, :js_disabled, :blacklisted,
              :comment, :codes,:fast_submit, :account_status, :allow

  def initialize body
    body = body.is_a?(String) ? JSON.parse(body) : body
    body.each do |meth, value|
      instance_variable_set("@#{meth}", value) if respond_to? meth
    end
  end
end
