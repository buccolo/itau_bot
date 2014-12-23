# This file is copied to spec/ when you run 'rails generate rspec:install'
require File.expand_path("../../lib/itau_bot", __FILE__)

require_relative './support/helpers'

RSpec.configure do |c|
  c.include Helpers
end
