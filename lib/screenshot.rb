require 'selenium-webdriver'

class Screenshot
  def self.take(url, file_name)
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to(url)
    driver.execute_script(File.read("lib/screenshot.js"))
    driver.manage.window.full_screen
    driver.save_screenshot("screenshots/#{file_name}.png")
    driver.quit
  end
end