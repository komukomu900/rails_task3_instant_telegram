class CreateMailer < ApplicationMailer
  def create_mail(contact)
    @contact = contact
    mail to: "zonghongorder@gmail.com", subject: "投稿確認メール"
  end
end