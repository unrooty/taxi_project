module Admin::Affiliate
  class Show < Trailblazer::Operation
    step Model(Affiliate, :find_by)
  end
end
