require 'selenium-webdriver'

class Screenshot

  def self.github_setup
    Selenium::WebDriver::Chrome::Service.driver_path = "/usr/bin/chromedriver"
  end

  def self.take(url, file_name)
    options = Selenium::WebDriver::Chrome::Options.new
    #options.add_argument('--headless')
    options.add_argument('--disable-gpu')

    driver = Selenium::WebDriver.for :chrome, options: options
    driver.navigate.to(url)
    driver.execute_script(File.read("lib/screenshot.js"))
    driver.manage.window.full_screen
    driver.save_screenshot("screenshots/#{file_name}.png")
    driver.quit
  end
end