class HomeController < ApplicationController
  def index; end

  def about; end

  def feedback_mail
    @feedback = Feedback.create(feedback_params)
    UserMailer.feedback_mail(@feedback).deliver
    flash[:notice] = t('send_feedback')
    redirect_to root_path
  end

  def routing_error
    p "routing error path: #{params[:path]}"
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  private

  def feedback_params
    params.require('/feedback').permit(:name, :email, :message)
  end
end
