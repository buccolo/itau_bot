$stdout.sync = true

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
    response = HTTParty.post(url, {
      body: compact_body(JSON.generate(payload))
    })

    puts "-----> Response: #{response.code}"
  end

  def compact_body(payload)
    Base64.encode64(Zlib::Deflate.deflate(payload))
  end
end

ItauBot.new.notify
