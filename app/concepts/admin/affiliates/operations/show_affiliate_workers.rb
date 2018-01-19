class Affiliate::ShowAffiliateWorkers < Trailblazer::Operation
  step Model(Affiliate, :find_by)
  step :find_workers!

  def find_workers!(options, *)
    options['workers'] = options['model'].users.where.not(role: :client)
  end
end