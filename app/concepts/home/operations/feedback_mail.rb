class Feedback::Create < Trailblazer::Operation

  step Wrap(SequelTransaction) {
    step Model(Feedback, :new)
    step Contract::Build()
    step Contract::Validate(key: :feedback)
    step Contract::Persist()
    step :send_feedback_mail
  }

  private

  def send_feedback_mail(_options, model:, **)
    UserMailer.feedback_mail(model).deliver
  end
end
