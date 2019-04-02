require 'watir'
require 'cucumber'
require 'page-object'
require 'rspec/expectations'
require 'fig_newton'
require 'report_builder'

require_relative 'helper/form_fill'
require_relative 'helper/validation_helper'

require_relative '../pages/splashmath'

World(PageObject::PageFactory)
World(FormHelper, ValidationHelper)

ENV['BROWSER'] = 'CHROME'

$test_environment = ENV['FIG_NEWTON_FILE']

RSpec::Expectations.configuration.on_potential_false_positives = :nothing