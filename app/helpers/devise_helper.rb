# Edit devise helper
module DeviseHelper
  def devise_error_messages!
    return '' unless devise_error_messages?

    m = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div class="error-color">
      <h3>#{t('error_user_new')}</h3>
      <ul>#{m}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end
end
