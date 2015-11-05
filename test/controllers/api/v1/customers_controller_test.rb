require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json
    assert_response :success
  end

  test "#index returns all of the instances of a customer" do
    create(:customer)
    create(:customer)

    get :index, format: :json
    assert_equal Customer.count, json_response.count
  end

  test "show" do
    customer = create(:customer)

    get :show, id: customer.id, format: :json
    assert_response :success
  end

  test "#show returns the right object description" do
    customer = create(:customer)

    get :show, id: customer.id, format: :json

    assert_equal customer.first_name, json_response["first_name"]
  end

  test "#find returns the specific instance of the customer" do
    customer = create(:customer)

    get :find, id: customer.id, format: :json

    assert_response :success
    assert_equal customer.first_name, json_response["first_name"]
  end

  test "#find_all returns all instances of a customer based on the query" do
    customer = create(:customer, first_name: "Rose", last_name: "Kohn")
    create(:customer, first_name: "Rose", last_name: "Ann")
    create(:customer)

    get :find_all, first_name: customer.first_name, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#random returns a random customer" do
    customer = create(:customer)
    create(:customer)
    create(:customer)
    create(:customer)

    same_instance = 0
    10.times do
      get :random, format: :json
      same_instance += 1 if json_response["first_name"] == customer.first_name
    end

    assert_response :success
    assert same_instance <= 7
  end

  test "#invoices returns all invoices connected to customer" do
    customer = create(:customer)
    create(:invoice, customer_id: customer.id)
    create(:invoice, customer_id: customer.id)
    create(:invoice)

    get :invoices, id: customer.id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#transactions returns all transactions connected to customer" do
    customer = create(:customer)
    invoice1 = create(:invoice, customer_id: customer.id)
    invoice2 = create(:invoice, customer_id: customer.id)
    create(:transaction, invoice_id: invoice1.id)
    create(:transaction, invoice_id: invoice2.id)
    create(:transaction)

    get :transactions, id: customer.id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#favorite_merchant returns the favorite merchant for a customer" do
    customer = create(:customer)
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
    invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
    create(:transaction, invoice_id: invoice1.id)
    create(:transaction, invoice_id: invoice2.id)
    create(:transaction, invoice_id: invoice3.id)

    get :favorite_merchant, id: customer.id, format: :json

    assert_response :success
    assert_equal merchant1.id, json_response["id"]
  end
end
