Before do
  @browser = Browser.open_browser ENV['BROWSER']
end

After do |scenario|
  if scenario.failed?
    encoded_img = @browser.driver.screenshot_as(:base64)
    embed("data:image/png;base64,#{encoded_img}", 'image/png')
  end
  @browser.quit unless @browser.nil?
end