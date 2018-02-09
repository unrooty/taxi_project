class Order::Index < Trailblazer::Operation
  step :model!

  private

  def model!(options, params, *)
    options[:model] = params[:current_user].orders
  end
end
