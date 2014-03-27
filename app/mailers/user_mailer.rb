class UserMailer < ActionMailer::Base
  default from: "tab4eight@gmail.com"
  
  def welcome_email(user, event)
    @event = event
    @user = user
    mail(to: @user.email,
         subject: "You Have been Invited")
  end
  
  def admin_email(user, event)
    @event = event
    @user = user
    mail(to: @user.email,
         subject: "Event Date and Time Confirmed")
  end
  
  def confirm_email(user, event)
    @event = event
    @user = user
    mail(to: @user,
         subject: "Event Date and Time Confirmed")
  end
end
