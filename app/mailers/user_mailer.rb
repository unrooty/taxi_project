# Mailer class for user
class UserMailer < ApplicationMailer
  default from: APP_SETTINGS['from_email']

  def welcome_email(user)
    @user = user
    @url = APP_SETTINGS['url']
    mail(to: @user.email, subject: t('welcome_email'))
  end

  def send_orders_mail(user, orders)
    @user = user
    @orders = orders
    mail(to: @user.email, subject: t('orders_report'))
  end

  def feedback_mail(feedback)
    @feedback = feedback
    @feedback_mail = 'exapmleemail@gmail.com'
    mail(to: @feedback_mail,
         subject: "#{t('feedback_from')} #{@feedback.name}
                   (#{@feedback.email})")
  end

  def invoice_report_mail(user, invoice)
    @user = user
    @invoice = invoice
    mail(to: @user.email, subject: t('order_info'))
  end

  def car_assignment_mail(user, car)
    @user = user
    @car = car
    mail(to: @user.email, subject: t('car'))
  end
end
