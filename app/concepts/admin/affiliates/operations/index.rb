
class Affiliate::Index < Trailblazer::Operation

  step :model!

  def model!(options, *)
    options['model'] = Affiliate.all
  end

end