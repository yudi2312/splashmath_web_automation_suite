class StudentDashboardPage < SplashMath

  link(:curriculum_tab, id: 'playlist')
  div(:dashboard, class: 'child-dashboard')

  expected_element_visible("dashboard", 15, true)

end