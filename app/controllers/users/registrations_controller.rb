class Users::RegistrationsController < Devise::RegistrationsController
  include ResultHandler

  def create
    result = User::Create.(params: params)
    handle_invalid(result) do
      build_resource
      @form.errors.messages.each do |attr, message|
        message.each { |m| resource.errors.add(attr, m) }
      end
      return render :new
    end
    super
  end

  def update
    result = User::Update.(params: params, current_user: current_user)
    handle_invalid(result) do
      @form.errors.messages.each do |attr, message|
        message.each { |m| resource.errors.add(attr, m) }
      end
      return render :edit
    end
    super
  end
end
