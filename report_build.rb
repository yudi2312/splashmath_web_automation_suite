require 'report_builder'
require 'fileutils'

ReportBuilder.configure do |config|
  config.input_path = "results/JSON"
  config.html_report_path = "results/merged_report"
  config.report_title = 'SM Web Automation Results'
  config.color = %w[lime cyan purple indigo grey].sample
  config.additional_info = { User: ENV['USER'] }
end

ReportBuilder.build_report

Dir.foreach("results/JSON") do |f|
  fn = File.join("results/JSON", f)
  File.delete(fn) if f!= '.' && f != '..'
end