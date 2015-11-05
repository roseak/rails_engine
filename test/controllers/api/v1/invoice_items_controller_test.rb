require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json
    assert_response :success
  end

  test "#index returns all of the instances of an invoice item" do
    create(:invoice_item)
    create(:invoice_item)

    get :index, format: :json
    assert_equal InvoiceItem.count, json_response.count
  end

  test "show" do
    invoice_item = create(:invoice_item)

    get :show, id: invoice_item.id, format: :json
    assert_response :success
  end

  test "#show returns the right object description" do
    invoice_item = create(:invoice_item)

    get :show, id: invoice_item.id, format: :json

    assert_equal invoice_item.quantity, json_response["quantity"]
  end

  test "#find returns the specific instance of the invoice item" do
    invoice_item = create(:invoice_item)

    get :find, id: invoice_item.id, format: :json

    assert_response :success
    assert_equal invoice_item.quantity, json_response["quantity"]
  end

  test "#find_all returns all instances of an invoice item based on the query" do
    invoice_item = create(:invoice_item, quantity: 8)
    create(:invoice_item, quantity: 8)
    create(:invoice_item, quantity: 2)

    get :find_all, quantity: invoice_item.quantity, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#random returns a random invoice item" do
    invoice_item = create(:invoice_item)
    create(:invoice_item)
    create(:invoice_item)
    create(:invoice_item)

    same_instance = 0
    10.times do
      get :random, format: :json
      same_instance += 1 if json_response["invoice_id"] == invoice_item.invoice_id
    end

    assert_response :success
    assert same_instance <= 8
  end

  test "#invoice returns the invoice related to the specific invoice item" do
    invoice = create(:invoice)
    create(:invoice)
    invoice_item = create(:invoice_item, invoice_id: invoice.id)

    get :invoice, id: invoice_item.id, format: :json

    assert_response :success
    assert_equal invoice.id, json_response["id"]
  end

  test "#item returns the item related to the specific invoice item" do
    item = create(:item)
    create(:item)
    invoice_item = create(:invoice_item, item_id: item.id)

    get :item, id: invoice_item.id, format: :json

    assert_response :success
    assert_equal item.name, json_response["name"]
  end
end
