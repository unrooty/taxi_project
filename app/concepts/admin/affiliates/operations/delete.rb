class Affiliate::Delete < Trailblazer::Operation
  step Model(Affiliate, :find_by)
  step :delete!

  def delete!(_options, model:, **)
    model.destroy
  end
end
