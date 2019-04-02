module FormHelper

  def enter_field_value(field, value = nil, obj = @current_page)

    field = field.formatize

    unless obj.respond_to? field
      raise "no object/field with name #{field} was found in #{obj.class} class"
    end

    verify_element_present(field, obj)

    case obj.send("#{field.formatize}_element").class.to_s
    when /textfield/i, /selectlist/i, /filefield/i, /textarea/i
      obj.send("#{field}=", value) unless obj.send(field) == value
    when /radio/i
      obj.send("select_#{field}")
    when /checkbox/i
      if value.downcase == "check"
        obj.send("check_#{field}")
      elsif value.downcase == "uncheck"
        obj.send("uncheck_#{field}")
      end
    else
      raise "wrong object type for this method"
    end
  end

  def click_element(field, obj = @current_page)
    if field.class == String
      field = field.formatize
      unless (obj.respond_to? field) || (obj.respond_to? "#{field}_element")
        raise "no object/field with name #{field} was found in #{obj.class} class"
      end
      field = obj.send("#{field.formatize}_element")
    end
    verify_element_present(field.element, timeout: 30)
    field.focus
    field.click
  end

  def get_text(field, obj = @current_page)
    verify_element_present(field)
    if field == String
      field = obj.send("#{field.formatize}_element")
    end
    case field.class.to_s
    when /textfield/i, /filefield/i, /textarea/i, /selectlist/i
      field.value.strip
    else
      field.text.strip
    end
  end
end