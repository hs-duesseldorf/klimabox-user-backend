class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = "#{Rails.configuration.url["base_url"]}/users/#{user.activation_token}/activate"
    mail(to: user.email, subject: "Klimabox Account Aktivierung")
  end

  def activation_success_email(user)
    @user = user
    @url  = "#{Rails.configuration.url["client_url"]}/signin"
    mail(to: user.email, subject: "Dein Klimabox Account ist aktiviert")
  end

  def reset_password_email(user)
    @user = User.find user.id
    @url  = "#{Rails.configuration.url["client_url"]}/reset_password?token=#{@user.reset_password_token}"
    mail(to: user.email, subject: "Passwort zurücksetzten")
  end
end