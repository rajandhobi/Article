# Preview all emails at http://localhost:3000/rails/mailers/rajan_mailer
class RajanMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/rajan_mailer/welcome_email
  def welcome_email
    RajanMailer.welcome_email
  end
end
