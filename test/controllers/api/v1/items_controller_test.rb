require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json
    assert_response :success
  end

  test "#index returns all of the instances of an item" do
    create(:item)
    create(:item)

    get :index, format: :json
    assert_equal Item.count, json_response.count
  end

  test "show" do
    item = create(:item)

    get :show, id: item.id, format: :json
    assert_response :success
  end

  test "#show returns the right object description" do
    item = create(:item)

    get :show, id: item.id, format: :json

    assert_equal item.name, json_response["name"]
  end

  test "#find returns the specific instance of the item" do
    item = create(:item)

    get :find, id: item.id, format: :json

    assert_response :success
    assert_equal item.name, json_response["name"]
  end

  test "#find_all returns all instances of an item based on the query" do
    item = create(:item, name: "apple")
    create(:item, name: "apple")
    create(:item, name: "banana")

    get :find_all, name: item.name, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#random returns a random item" do
    item = create(:item)
    create(:item)
    create(:item)
    create(:item)

    same_instance = 0
    10.times do
      get :random, format: :json
      same_instance += 1 if json_response["name"] == item.name
    end

    assert_response :success
    assert same_instance <= 8
  end

  test "#invoice_items returns all invoice items connected to item" do
    item = create(:item)
    create(:invoice_item, item_id: item.id)
    create(:invoice_item, item_id: item.id)
    create(:invoice_item)

    get :invoice_items, id: item.id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#merchant returns the merchant associated with the item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get :merchant, id: item.id, format: :json

    assert_response :success
    assert_equal merchant.name, json_response["name"]
  end
end
