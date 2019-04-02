class ParentDashboardPage < SplashMath

  link(:curriculum_tab, xpath: "//li[@class='js-curriculum-tab tab ']/a")

  expected_element_visible("curriculum_tab", 30, true)

end