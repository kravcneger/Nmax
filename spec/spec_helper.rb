require 'rubygems'
require 'bundler/setup'
# our gem
require 'nmax'
require 'nmax/pq'
require 'nmax/digits_reader'

RSpec.configure do |config|
  config.failure_color = :red
  config.tty = true
  config.color = true
end