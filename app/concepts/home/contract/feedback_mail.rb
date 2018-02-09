module Contract
  class FeedbackMailSend < Reform::Form
    property :name
    property :email
    property :message
  end
end
