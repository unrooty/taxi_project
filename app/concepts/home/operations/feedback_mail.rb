class Feedback::Create < Trailblazer::Operation
  extend Contract::DSL

  contract do
    property :name
    property :email
    property :message
  end

  step Wrap ->(*, &block) { Feedback.transaction { block.call } } {
    step Model(Feedback, :new)
    step Contract::Build()
    step Contract::Validate(key: :feedback)
    step Contract::Persist()
    step :send_feedback_mail
  }

  private

  def send_feedback_mail(options, *)
    UserMailer.feedback_mail(options['model']).deliver
  end
end
