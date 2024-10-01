require "selenium-webdriver"

module Screenshot
  def self.github_setup
    Selenium::WebDriver::Chrome::Service.driver_path = "/usr/bin/chromedriver"
  end

  def screenshot
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless")
    options.add_argument("--disable-gpu")
    options.add_argument("--hide-scrollbars")
    options.add_argument("--window-size=#{screenshot_dimensions}")
    options.add_argument("--headless=old")

    driver = Selenium::WebDriver.for :chrome, options: options
    driver.navigate.to(link)
    driver.execute_script(File.read("lib/screenshot.js"))
    driver.manage.window.full_screen
    driver.save_screenshot("screenshots/#{name}.png")
    driver.quit
  end
end