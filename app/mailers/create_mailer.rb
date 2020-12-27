class CreateMailer < ApplicationMailer
  def create_mail(contact)
    @contact = contact
    mail to: @contact.user.email, subject: "投稿確認メール"
  end
end