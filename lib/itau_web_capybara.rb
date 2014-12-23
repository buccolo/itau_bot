Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, { js_errors: false })
end

Capybara.current_driver = :poltergeist
Capybara.run_server = false
Capybara.app_host = "https://www.itau.com.br"
