require 'rubygems'
require 'spork'
require 'spork/ext/ruby-debug'

def with_airpot_vcr
  VCR.use_cassette 'amazon/airpot' do
    yield
  end
end

def with_stub_products
  product = mock_model(Product)
  product.stub(:title).and_return("RC Helicopter")
  product.stub(:img_src).and_return("http://www.amazon.com/img.jpg")
  product.stub(:price).and_return(35.99)
  Product.stub(:all).and_return([product])
  Product.stub(:order).and_return([product])
  yield
end

def with_ar_products
  @product = Product.create(
    title: "RC Helicopter",
    img_src: "http://www.amazon.com/img.jpg",
    url: "helicopter",
    price: 35
  )
  yield
  Product.delete_all
end

def time_travel_and_return(travel_to_date)
  current_time = Time.zone.now
  travel_to_date = Time.zone.parse(travel_to_date) if travel_to_date.is_a? String
  Timecop.travel(travel_to_date)
  yield
ensure
    Timecop.travel(current_time)
end

Spork.prefork do

  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end


  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    if Settings.use_phantomjs
        require 'capybara/poltergeist'
        Capybara.javascript_driver = :poltergeist
    end

  end
end

Spork.each_run do
  if ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

end

