class Affiliate::Show < Trailblazer::Operation
  step Model(Affiliate, :[])
end
