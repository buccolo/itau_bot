require 'json'
require 'httparty'
require 'capybara/poltergeist'

require_relative './itau_web_capybara'
require_relative './itau_web_scraper'
require_relative './itau_web_parser'
require_relative './itau_web_credentials'

class ItauBot
  def notify
    puts "-----> Starting ItauBot"
    payload = ItauWebScraper.new.scrape
    payload.merge!({
      success: true
    })
  rescue => e
    payload = {
      success: false,
      message: e.message,
      backtrace: e.backtrace
    }

    puts "-----> Fail: #{e.message}"
  ensure
    url = ENV['ITAU_BOT_URL']

    puts "-----> Notifying: #{url}"
    HTTParty.post(url, {
      body: JSON.pretty_generate(payload)
    })
  end
end

ItauBot.new.notify
