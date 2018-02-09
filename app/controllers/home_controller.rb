class HomeController < ApplicationController
  def index; end

  def about; end

  def feedback_mail
    result = Feedback::Create.call(params)
    handle_successful(result) do
      redirect_to root_path, notice: t('send_feedback')
    end
  end

  def routing_error
    p "routing error path: #{params[:path]}"
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end
