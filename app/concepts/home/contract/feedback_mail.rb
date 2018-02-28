module Feedback::Contract
  class FeedbackMailSend < Reform::Form
    property :name
    property :email
    property :message

    validates :name, :email, :message, presence: true
    validates :message, length: { minimum: 10 }
    validates :email, format: /\A[^@\s]+@[^@\s]+\z/
  end
end
