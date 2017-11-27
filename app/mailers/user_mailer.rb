class UserMailer < ApplicationMailer

  def invite(user,course)
    @user = user
    @course = course
    mail(to: @user.email, subject: 'Welcome!')
  end
end
