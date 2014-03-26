class UserMailer < ActionMailer::Base
  default from: "tab4eight@gmail.com"
  
   def welcome_email(user, event)
    @event = event
    @user = user
    delivery_options = { user_name: 'tab4eight@gmail.com',
                         password: 'tab4eight1234',
                         address: 'smtp.gmail.com',
                         port: '465' }
    mail(to: @user.email,
         subject: "You Have been Invited",
         delivery_method_options: delivery_options)
  end
end
