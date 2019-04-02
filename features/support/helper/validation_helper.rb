module ValidationHelper

  def verify_element_present(field, obj = @current_page, timeout: 10, message: nil)
    if field.class == String
      field = obj.send("#{field.formatize}_element").element
    end
    expect {field.wait_until(timeout: timeout, &:present?) }.not_to raise_error, message
  end

  def verify_element_not_present(field, obj = @current_page, timeout: 10, message: nil)
    if field.class == String
      field = obj.send("#{field.formatize}_element").element
    end
    expect {field.wait_until(timeout: timeout, &:present?) }.to raise_error, message
  end

end