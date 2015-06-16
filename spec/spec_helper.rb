require 'simplecov'

SimpleCov.start do
  add_filter '/spec'
end if ENV['COVERAGE']

require File.expand_path('../../lib/nfedobrasil', __FILE__)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = 'random'
end
