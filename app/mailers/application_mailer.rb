class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILADDRESS']
  layout 'mailer'
end
