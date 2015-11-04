require 'simplecov'
SimpleCov.start('rails')
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'factory_girl_rails'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all
  include FactoryGirl::Syntax::Methods
end
