class Affiliate::Show < Trailblazer::Operation
  step Model(Affiliate, :find_by)
end
