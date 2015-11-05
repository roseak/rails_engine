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

  def business_merchants_setup
    merchant = create(:merchant)
    invoice1 = create(:invoice, merchant_id: merchant.id)
    invoice2 = create(:invoice, merchant_id: merchant.id)
    create(:transaction, invoice_id: invoice1.id)
    create(:transaction, invoice_id: invoice2.id)
    create(:invoice_item, invoice_id: invoice1.id)
    create(:invoice_item, invoice_id: invoice1.id)
    create(:invoice_item, invoice_id: invoice2.id)
    merchant
  end
end
