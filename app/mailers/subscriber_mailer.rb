class SubscriberMailer < ActionMailer::Base
  default from: "blog@aarondilley.com"

  def welcome_email(user)
    @user            = user
    @unsubscribe_url = "http://aarondilley.com/subscribers/delete/#{@user.email}"
    mail(
      to:      @user.email,
      subject: "Thanks for Subscribing"
    )
  end
end
