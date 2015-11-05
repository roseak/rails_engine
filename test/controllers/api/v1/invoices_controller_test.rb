require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json
    assert_response :success
  end

  test "#index returns all of the instances of an invoice" do
    create(:invoice)
    create(:invoice)

    get :index, format: :json
    assert_equal Invoice.count, json_response.count
  end

  test "show" do
    invoice = create(:invoice)

    get :show, id: invoice.id, format: :json
    assert_response :success
  end

  test "#show returns the right object description" do
    invoice = create(:invoice)

    get :show, id: invoice.id, format: :json

    assert_equal invoice.merchant_id, json_response["merchant_id"]
  end

  test "#find returns the specific instance of the invoice" do
    invoice = create(:invoice)

    get :find, id: invoice.id, format: :json

    assert_response :success
    assert_equal invoice.customer_id, json_response["customer_id"]
  end

  test "#find_all returns all instances of an invoice based on the query" do
    merchant = create(:merchant)
    create(:invoice, merchant_id: merchant.id)
    create(:invoice, merchant_id: merchant.id)
    create(:invoice)

    get :find_all, merchant_id: merchant.id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#random returns a random invoice" do
    invoice = create(:invoice)
    create(:invoice)
    create(:invoice)
    create(:invoice)

    same_instance = 0
    10.times do
      get :random, format: :json
      same_instance += 1 if json_response["merchant_id"] == invoice.merchant_id
    end

    assert_response :success
    assert same_instance <= 7
  end

  test "#transactions returns all transactions connected to invoice" do
    invoice = create(:invoice)
    create(:transaction, invoice_id: invoice.id)
    create(:transaction, invoice_id: invoice.id)
    create(:transaction)

    get :transactions, id: invoice.id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#invoice_items returns all invoice items connected to invoice" do
    invoice = create(:invoice)
    create(:invoice_item, invoice_id: invoice.id)
    create(:invoice_item, invoice_id: invoice.id)
    create(:invoice_item)

    get :invoice_items, id: invoice.id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#items returns all items connected to invoice" do
    invoice = create(:invoice)
    item1 = create(:item)
    item2 = create(:item)
    create(:invoice_item, item_id: item1.id, invoice_id: invoice.id)
    create(:invoice_item, item_id: item2.id, invoice_id: invoice.id)

    get :items, id: invoice.id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#customer returns the specific customer related to the item" do
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id)

    get :customer, id: invoice.id, format: :json

    assert_response :success
    assert_equal customer.first_name, json_response["first_name"]
  end

  test "#merchant returns the specific merchant related to the item" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id)

    get :merchant, id: invoice.id, format: :json

    assert_response :success
    assert_equal merchant.name, json_response["name"]
  end
end
