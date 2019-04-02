class ClassroomSettingsPage < SplashMath

  page_section(:class_settings, self, xpath: "//input[@value='CLASS_1']/parent::div/parent::div/parent::li/parent::ul")

  def class_settings(class_name)
    xpath = "//input[@value='" + class_name.strip.upcase + "']/parent::div/parent::div/parent::li/parent::ul"
    ClassroomSettingsPage.new(@browser.element(xpath: xpath))
  end

  radio(:show_student_username, id: /select-show-student-username-yes-.*/)
  radio(:show_student_username_yes, id: /select-show-student-username-yes-.*/)
  radio(:show_student_username_no, id: /select-show-student-username-no-.*/)

  link(:save_changes_class, id: 'submit-class-settings')

end