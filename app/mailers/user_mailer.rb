class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail(to: user.email, subject: "Bienvenue sur SYKE !")
  end

  def new_meeting(meeting)
    @meeting = meeting
    @user_competency = meeting.user_competency
    @helper = meeting.helper
    @helpee = meeting.helpee
    mail(to: @helper.email, subject: "Nouvelle demande sur SYKE !")
  end
end
