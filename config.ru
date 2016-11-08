env = ENV['RACK_ENV'].to_sym || :development

require "bundler/setup"
Bundler.require(:default, env)

require_relative 'tokenate.rb'
run Tokenate
