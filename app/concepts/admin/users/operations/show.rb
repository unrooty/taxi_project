module Admin::User
  class Show < Trailblazer::Operation
    step Model(User, :find_by)
  end
end
