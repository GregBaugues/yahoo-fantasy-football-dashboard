require 'rubygems'
require 'spork'

Spork.prefork do

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  RSpec.configure do |config|
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"
  end

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  VCR.configure do |c|
    c.cassette_library_dir = Rails.root.join("spec", "vcr")
    c.hook_into :fakeweb
    c.filter_sensitive_data('CONSUMER_KEY' ) { Settings.consumer_key }
    c.filter_sensitive_data('CONSUMER_SECRET') { Settings.consumer_secret }
  end

end

Spork.each_run do

end
