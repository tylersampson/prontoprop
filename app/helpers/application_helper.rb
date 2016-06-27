module ApplicationHelper
  def gravatar_img_tag(user)
    id = Digest::MD5.hexdigest(user&.email.to_s.downcase)
    image_tag("http://gravatar.com/avatar/#{id}")
  end

  def saved_index_path
    send("#{params[:controller].pluralize}_path", session["params_#{params[:controller]}"])
  end

  def pager_per_select
    form_tag nil, method: :get do
      label_tag("Display:") + "&nbsp;".html_safe + 
      select_tag('per', options_for_select([10,20,30,50,100,200], session[:default_per]))
    end
  end

  def flash_messages
    messages = []
    flash.each do |type, message|
      puts type
      case type.to_s
      when 'success'
        bg = '#739E73'
        icon = 'fa fa-check swing animated'
      when 'alert'
        bg = '#C46A69'
        icon = 'fa fa-warning shake animated'
      else
        bg = '#3276B1'
        icon = 'fa fa-bell shake animated'
      end

      text = "<flash-message title=\"#{type}\" color=\"#{bg}\" icon=\"#{icon}\">#{message}</flash-message>"

      messages << text.html_safe if message
    end
    messages.join("\n")
  end

  def widget(title = "", icon_name = "info", options = {}, &block)
    options[:data] ||= {}
    options[:data]['widget-colorbutton'] = false
    options[:data]['widget-deletebutton'] = false
    options[:data]['widget-editbutton'] = false
    options[:data]['widget-togglebutton'] = false
    options[:data]['widget-fullscreenbutton'] = false
    options[:class] = "jarviswidget"
    content_tag(:div, options) do
      content_tag(:header) do
        content_tag(:span, icon(icon_name), class: 'widget-icon') +
        content_tag(:h2, title)
      end +
      content_tag(:div) do
        content_tag(:div, class: 'widget-body', &block)
      end
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder, title: new_object.class.model_name.human)
    end
    link_to(name, '#', class: "btn btn-info", data: {behavior: 'add_fields', id: id, fields: fields.gsub("\n", "")})
  end
end
