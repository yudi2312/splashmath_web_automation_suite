When(/^the user is on the home page$/) do
  visit_page(SplashMath)
end

And(/^the user clicks on (.+) skill$/) do |skill|
  @current_page.open_skill(skill)
end

And(/^the user plays the count forward game$/) do

  @current_page.wait_until(15) { @current_page.topic? }
  @current_page.wait_until(15) { @current_page.question? }

  sleep 5

  while @current_page.question?

    question = @current_page.question.strip
    @browser.driver.switch_to.frame("sp-iframe")
    frame = @browser.iframe(:id => "sp-iframe")

    if question.include? "Drag numbers to their correct places"
      table = frame.table(:class => ['pair-numbers', 'dd-row-drop'])
      latest_num = 0
      table.rows[0].tds.each do |cell|
        if cell.text.strip.empty?
          latest_num += 1
          source = frame.div(:class => ["dd-live", "counter", "draggable-test", /draggable-\d+/], :text => "#{latest_num}")
          source.wait_until(&:present?)
          source.drag_and_drop_on cell
        else
          latest_num = cell.text.strip.to_i
        end
      end

      click_element 'done'

    elsif question.include? 'Which is the missing number'

      @current_page.wait_until(15) { frame.td(:class => 'missing').span.text == "?" }
      missing_num = frame.td(:xpath => "//td[@class='missing']/preceding-sibling::td[1]").text.to_i + 1
      frame.div(:class => "choice-text", :text => "#{missing_num}").wait_until(&:present?)
      sleep 1
      frame.div(:class => "choice-text", :text => "#{missing_num}").click

    elsif question.include? "What comes next"

      @current_page.wait_until(15) { frame.span(:class => %w[sequence-step missing]).span.text == "?" }
      missing_num = frame.span(:xpath => "//span[@class='sequence-step missing']/preceding-sibling::span[1]").text.to_i + 1
      frame.div(:class => "choice-text", :text => missing_num).wait_until(&:present?)
      sleep 1
      frame.div(:class => "choice-text", :text => missing_num).click

    end

    sleep 5

  end

end