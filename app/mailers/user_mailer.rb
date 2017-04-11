class UserMailer < ApplicationMailer
  def account_activation user   
    @user = user
    mail to: user.email, subject: t("acc_activation")
  end

  def password_reset
    @greeting = t "hi"
    mail to: Settings.mail.to
  end
end
