# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/invite
  def invite
    user = User.first
    course = Course.first
    UserMailer.invite(user, course)
  end

end
