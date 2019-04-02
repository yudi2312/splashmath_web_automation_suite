Then(/^the show student username setting should (be|not be) displayed$/) do |should|
  sleep 3
  element = on_page(ClassroomSettingsPage).class_settings(@user_data['class'].tr(' ', '_')).show_student_username_yes_element.element
  if should == 'be'
    verify_element_present element
    # expect(on_page(ClassroomSettingsPage).class_settings(@user_data['class'].tr(' ', '_')).show_student_username_yes?).to be_truthy
  else
    verify_element_not_present element
    # expect(on_page(ClassroomSettingsPage).class_settings(@user_data['class'].tr(' ', '_')).show_student_username_yes?).to be_falsey
  end
end

And(/^student username and password should (?:be|not be) displayed when setting is turned (on|off)$/) do |on_off|
  unless @browser.url.include? 'classroom_setting'
    click_element 'option dropdown', on_page(TeacherHomePage)
    click_element 'classroom setting', on_page(TeacherHomePage)
  end
  on_page(ClassroomSettingsPage)

  if on_off == "on"
    @current_page.class_settings(@user_data['class'].tr(' ', '_')).show_student_username_yes_element.parent.label.click
  else
    @current_page.class_settings(@user_data['class'].tr(' ', '_')).show_student_username_no_element.parent.label.click
  end

  click_element 'save_changes_class'
  @browser.div(class: 'noty_message').wait_while(&:present?)
  sleep 4
  @browser.back

  on_page(TeacherHomePage) do |page|
    page.select_class(@user_data['class'])
    i = 0
    begin
      i += 1
      click_element 'class_management_tab', page
      verify_element_present 'table_container', page
    rescue Exception => e
      retry unless i > 1
    end

  end

  header = @current_page.table_container_element.li(class: 'table-head')

  if on_off == 'on'
    verify_element_present header.li(class: 'uname'), timeout: 5, message: 'Username column was not present in the table'
    verify_element_present header.li(class: 'pwd'), timeout: 5, message: 'Password column was not present in the table'
    @current_page.table_container_element.ul.lis[1..-1].each do |row|
      expect( get_text(row.li(xpath: "//li[contains(@class, 'uname username')]")).empty? ).to be_falsey, 'Username column was found to be blank'
      expect( row.li(xpath: "//li[contains(@class, 'pwd password')]").img.present? || !get_text(row.li(xpath: "//li[contains(@class, 'pwd password')]")).empty? ).to be_truthy, 'Password column was found to be blank'
      # expect( row.li(xpath: "//li[contains(@class, 'uname username')]").text.empty? ).to be_falsey, 'Username column was found to be blank'
      # expect( row.li(xpath: "//li[contains(@class, 'pwd password')]").img.present? || !row.li(xpath: "//li[contains(@class, 'pwd password')]").text.empty? ).to be_truthy, 'Password column was found to be blank'
    end
  else
    verify_element_not_present header.li(class: 'uname'), timeout: 5, message: 'Username column was present in the table'
    verify_element_not_present header.li(class: 'pwd'), timeout: 5, message: 'Password column was present in the table'
  end

end