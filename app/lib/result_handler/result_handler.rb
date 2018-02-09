require 'matcher'

module ResultHandler
  include Matcher

  def handle_successful(result)
    match(%w[success unauthorized not_found]).call(result) do |m|
      m.success do
        form_and_model_return(result)
        yield if block_given?
      end
      m.unauthorized { redirect_to unauthorized_redirect_path }
      m.not_found { redirect_to not_found_redirect_path }
    end
  end

  def handle_invalid(result)
    match(%w[invalid]).call(result) do |m|
      m.invalid do
        form_and_model_return(result)
        yield if block_given?
      end
    end
  end

  def unauthorized_redirect_path
    admin_orders_path
  end

  def not_found_redirect_path
    admin_orders_path
  end

  def form_and_model_return(result)
    @model = result[:model]
    @form = result['contract.default']
  end
end
