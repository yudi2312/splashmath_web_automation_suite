class Browser

  attr_accessor :browser

  class << self

    def open_browser(browser = "chrome")
      case browser.strip.downcase
      when 'ie'
        @browser = Watir::Browser.new :ie
      when 'chrome'
        Selenium::WebDriver::Chrome.driver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"../", "external","chromedriver")
        @browser = Watir::Browser.new :chrome, chrome_options: {detach: true}
      when 'safari'
        @browser = Watir::Browser.new :safari
      when 'firefox'
        #TODO
      # when "headless"
      #   driver = Selenium::WebDriver.for :remote, {
      #       :url => 'http://localhost:4444/wd/hub',
      #       :desired_capabilities => :htmlunitwithjs
      #   }
      #   @browser = Watir::Browser.new(driver)
      else
        raise "Invalid browser #{browser}. Please re-check and start again."
      end
      @browser.window.maximize
      @browser
    end

    def navigate_to(url)
      @browser.goto url unless url.strip.empty?
    end

    def get_current_url
      @browser.url
    end

    def close_alert
      @browser.alert.close if @browser.alert.exists?
    end

    def accept_alert
      @browser.alert.ok if @browser.alert.exists?
    end

    def get_title
      @browser.title
    end

  end

end