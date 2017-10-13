# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def send_orders_mail
    @user = User.first
    UserMailer.send_orders_mail(@user, @user.orders.all)
  end
end
