class UserMailer < ActionMailer::Base
  default from: "tab4eight@gmail.com"

  def welcome_email(user, event)
    @event = event
    @user = user
    mail(to: @user.email,
         subject: "You have been invited to an event")
  end

  def admin_email(user, event)
    @event = event
    @users = user
    mail(to: @event.organiser_email,
         subject: "Event date and time confirmed")
  end

  def admin_welcome_email(event)
    @event = event
    mail(to: @event.organiser_email,
         subject: "Invites have been sent")
  end

  def confirm_email(user, event)
    @event = event
    @user = user
    mail(to: @user.email,
         subject: "Event date and time confirmed")
  end
end
