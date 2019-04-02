And(/^the user clicks on (.+) (?:tab|link|object|icon|section|element|button)$/) do |element|
  click_element(element)
end

Given(/^the user login as (.+)$/) do |user|
  visit_page(LandingPage)
  click_element 'sign in'

  @user_data = FigNewton.send(user.formatize).to_hash
  @user_data['role'] = @user_data['role'].strip.downcase
  @user_data['password'] = '123456' unless @user_data.key? 'password'

  click_element @user_data['role'], on_page(LoginPage)
  enter_field_value 'username', @user_data['username']
  enter_field_value 'password', @user_data['password']
  click_element 'sign in', on_page(LoginPage)

end

Then(/^(?:student|teacher|parent) dashboard(?: page|) should be displayed$/) do
  if @user_data['role'] == 'teacher'
    on_page(TeacherHomePage).has_expected_element_visible?
  elsif @user_data['role'] == 'parent'
    on_page(ParentDashboardPage).has_expected_element_visible?
  elsif @user_data['role'] == 'student'
    on_page(StudentDashboardPage).has_expected_element_visible?
  else
    raise "Invalid role #{@user_data['role']}. Terminating execution."
  end
end

And(/^the user selects student on Select Account Page$/) do
  on_page(SelectAccountPage).select_student(@user_data['student'])
end

When(/^the application navigates to the (.+) page$/) do |page|
  on_page(page.split(' ').map(&:capitalize).join + 'Page')
end