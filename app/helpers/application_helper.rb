module ApplicationHelper
  def flash_messages
    html = ''

    flash.each do |type, messages|
      messages.reject!(&:blank?) if messages.is_a?(Array)

      next if messages.blank?

      case type
      when 'timedout'
        next
      when 'notice'
        type = 'success'
      when 'alert'
        type = 'danger'
      end

      html += "<div class='alert alert-#{type}'>"
      html += '<button class="close" data-dismiss="alert"><i class="pci-cross pci-circle"></i></button>'

      if messages.is_a? Array
        html += '<ul style="padding-left: 20px;">'
        messages.each { |message| html += "<li>#{message}</li>" }
        html += '</ul>'
      else
        html += messages
      end

      html += '</div>'
    end

    html.html_safe
  end

  def validation_messages_for(object)
    return unless object.errors.any?

    html = ''
    html += '<div class="alert alert-danger">'
    html += '<button class="close" data-dismiss="alert"><i class="pci-cross pci-circle"></i></button>'

    if object.errors.full_messages.size > 1
      html += '<ul style="padding-left: 20px;">'
      object.errors.full_messages.uniq.each { |message| html += "<li>#{message}</li>" }
      html += '</ul>'
    else
      html += object.errors.full_messages.first
    end

    html += '</div>'

    html.html_safe
  end
end
