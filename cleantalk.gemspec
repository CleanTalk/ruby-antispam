Gem::Specification.new do |s|
  s.name        = 'cleantalk'
  s.version     = '0.2.0'
  s.licenses    = ['MIT']
  s.summary     = "Talk to cleantalk.org API for antispam"
  s.description = ""
  s.authors     = [""]
  s.email       = ""
  s.files       = ["lib/cleantalk.rb",
                   "lib/cleantalk/check_message.rb",
                   "lib/cleantalk/check_message_result.rb",
                   "lib/cleantalk/check_newuser.rb",
                   "lib/cleantalk/check_newuser_result.rb",
                   "lib/cleantalk/request.rb",
                   "lib/cleantalk/result.rb"]
  s.homepage    = "https://github.com/CleanTalk/ruby-antispam"
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'webmock', '~> 3.0'
end
