module Admin::Car
  class Index < Trailblazer::Operation
    step Policy::Pundit(Admin::CarsPolicy, :can_work_with_car?)
    step :model!

    private

    def model!(options, *)
      if options[:current_user].role == 'Admin'
        options[:model] = Car.all
      else
        options[:model] = Car.where(affiliate_id:
                                        options[:current_user].affiliate_id)
      end
    end
  end
end
