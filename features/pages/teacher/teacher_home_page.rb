class TeacherHomePage < SplashMath

  link(:option_dropdown, id: 'dropdownmenu' )
  link(:classroom_setting, href: '/classroom_setting')

  i(:choose_class, xpath: "//a[@data-clicked='Classes Tab']/i")
  unordered_list(:class_list, class: 'klasses-menu-list')

  # Grade Drop Down section
  div(:grade_division, class: %w[grade-dropdown dropdown transparent-grade-dropdown])
  link(:grade) { |e| e.grade_division_element.link_element}
  unordered_list(:grade_drop_down_options, class: %w(dropdown-menu grade-dropdown-menu))
  link(:kindergarten) { |e| e.grade_drop_down_options_element.link_element(href: /kindergarten/) }
  (1..5).each do |i|
    link("grade_#{i}".to_s) { |e| e.grade_drop_down_options_element.link_element(href: /#{i.text_ordinalize}-grade/) }
  end

  link(:curriculum_tab, href: /class\/.+\/curriculum/)
  link(:class_management_tab, xpath: "//a[contains(@href, 'roster')]")

  div(:table_container, class: 'js-student-roster-table-container')

  expected_element_visible('curriculum_tab', 30)

  def select_class(class_name)

    return if get_text(@browser.h1(class: 'dash-sub-head')).downcase.include? class_name.downcase

    class_name = class_name.strip
    @browser.execute_script( 'arguments[0].scrollIntoView()' , self.choose_class_element.element)
    self.choose_class_element.fire_event('onclick')
    self.class_list_element.span(text: /#{class_name}/i).fire_event('onclick')
    expect(get_text(@browser.h1(class: 'dash-sub-head'))).to include(class_name)
  end

  def select_grade(grade)
    return if get_text('grade').casecmp(grade.downcase).zero?

    verify_element_present 'grade', timeout: 15, message: 'grade was not present'
    click_element 'grade'
    click_element grade
    expect(get_text('grade')).to include(grade)
  end

end