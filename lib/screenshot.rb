require "selenium-webdriver"

class Screenshot

  def self.github_setup
    Selenium::WebDriver::Chrome::Service.driver_path = "/usr/bin/chromedriver"
  end

  def self.take(object)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=#{object.screenshot_dimensions}")

    driver = Selenium::WebDriver.for :chrome, options: options
    driver.navigate.to(object.link)
    driver.execute_script(File.read("lib/screenshot.js"))
    driver.manage.window.full_screen
    driver.save_screenshot("screenshots/#{object.name}.png")
    driver.quit
  end
end