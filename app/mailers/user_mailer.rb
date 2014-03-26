class UserMailer < ActionMailer::Base
  default from: "tab4eight@gmail.com"
  
   def welcome_email(user, event)
    @event = event
    @user = user
    mail(to: @user.email,
         subject: "You Have been Invited",
  end
end
