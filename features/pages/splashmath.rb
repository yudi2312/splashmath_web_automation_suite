class SplashMath

  include PageObject
  include RSpec::Matchers
  include ValidationHelper
  include FormHelper

  link(:curriculum, href: '/math-skills/kindergarten/curriculum')
  link(:features_and_plans, text: 'Features & Plans')

  span(:practice_now, text: 'Practice Now')

  link(:save_changes, text: 'Save Changes')
  link(:logo, xpath: "//img[@alt='Logo']/parent::a[1]")

  # # sections
  # div(:topic, id: 'popup-topic')
  #
  # in_iframe(id: 'sp-iframe') do |iframe|
  #   div(:question, class: 'question ', frame: iframe)
  #   span(:done, class: 'done-text', frame: iframe)
  #   div(:earned_coins, class: 'user-coins-earned', frame: iframe )
  # end
  #
  # def open_skill(skill)
  #   @browser.link(text: /#{skill}/i).click
  # end

end