require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json
    assert_response :success
  end

  test "#index returns all of the instances of a merchant" do
    create(:merchant)
    create(:merchant)

    get :index, format: :json
    assert_equal Merchant.count, json_response.count
  end

  test "show" do
    merchant = create(:merchant)

    get :show, id: merchant.id, format: :json
    assert_response :success
  end

  test "#show returns the right object description" do
    merchant = create(:merchant)

    get :show, id: merchant.id, format: :json

    assert_equal merchant.name, json_response["name"]
  end

  test "#find returns the specific instance of the merchant" do
    merchant = create(:merchant)

    get :find, id: merchant.id, format: :json

    assert_response :success
    assert_equal merchant.name, json_response["name"]
  end

  test "#find_all returns all instances of a merchant based on the query" do
    merchant = create(:merchant, name: "Awesome Sauce")
    create(:merchant, name: "Awesome Sauce")
    create(:merchant)

    get :find_all, name: merchant.name, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#random returns a random merchant" do
    merchant = create(:merchant)
    create(:merchant)
    create(:merchant)
    create(:merchant)

    same_instance = 0
    10.times do
      get :random, format: :json
      same_instance += 1 if json_response["name"] == merchant.name
    end

    assert_response :success
    assert same_instance <= 7
  end

  test "#invoices returns all invoices connected to merchant" do
    merchant = create(:merchant)
    create(:invoice, merchant_id: merchant.id)
    create(:invoice, merchant_id: merchant.id)
    create(:invoice)

    get :invoices, id: merchant.id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#items returns all items connected to merchant" do
    merchant = create(:merchant)
    create(:item, merchant_id: merchant.id)
    create(:item, merchant_id: merchant.id)
    create(:item)

    get :items, id: merchant.id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#revenue returns the total revenue for a merchant" do
    merchant = business_merchants_setup

    get :revenue, id: merchant.id, format: :json

    assert_response :success
    assert_equal merchant.revenue.to_s, json_response["revenue"]
  end

  test "#favorite_customer returns the favorite customer for a merchant" do
    merchant = create(:merchant)
    customer1 = create(:customer)
    customer2 = create(:customer)
    invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
    invoice2 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
    invoice3 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
    create(:transaction, invoice_id: invoice1.id)
    create(:transaction, invoice_id: invoice2.id)
    create(:transaction, invoice_id: invoice3.id)

    get :favorite_customer, id: merchant.id, format: :json

    assert_response :success
    assert_equal customer1.id, json_response["id"]
  end
end
