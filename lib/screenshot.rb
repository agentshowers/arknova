require 'selenium-webdriver'

class Screenshot

  def self.setup(github)
    @@options = Selenium::WebDriver::Chrome::Options.new
    if github
      Selenium::WebDriver::Chrome::Service.driver_path = "/usr/bin/chromedriver"
      @@options.add_argument('--headless')
      @@options.add_argument('--disable-gpu')
    end
  end

  def self.take(url, file_name)
    driver = Selenium::WebDriver.for :chrome, options: @@options
    driver.navigate.to(url)
    driver.execute_script(File.read("lib/screenshot.js"))
    driver.manage.window.full_screen
    driver.save_screenshot("screenshots/#{file_name}.png")
    driver.quit
  end
end