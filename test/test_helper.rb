require 'simplecov'
SimpleCov.start('rails')
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'factory_girl_rails'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  def json_response
    JSON.parse(response.body)
  end
end
