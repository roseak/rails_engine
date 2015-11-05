require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json
    assert_response :success
  end

  test "#index returns all of the instances of a transaction" do
    create(:transaction)
    create(:transaction)

    get :index, format: :json
    assert_equal Transaction.count, json_response.count
  end

  test "show" do
    transaction = create(:transaction)

    get :show, id: transaction.id, format: :json
    assert_response :success
  end

  test "#show returns the right object description" do
    transaction = create(:transaction)

    get :show, id: transaction.id, format: :json

    assert_equal transaction.invoice_id, json_response["invoice_id"]
  end

  test "#find returns the specific instance of the transaction" do
    transaction = create(:transaction)

    get :find, id: transaction.id, format: :json

    assert_response :success
    assert_equal transaction.credit_card_number, json_response["credit_card_number"]
  end

  test "#find_all returns all instances of a transaction based on the query" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id, result: "failed")
    create(:transaction, invoice_id: invoice.id)
    create(:transaction)

    get :find_all, invoice_id: transaction.invoice_id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "#random returns a random transaction" do
    transaction = create(:transaction)
    create(:transaction)
    create(:transaction)
    create(:transaction)

    same_instance = 0
    10.times do
      get :random, format: :json
      same_instance += 1 if json_response["credit_card_number"] == transaction.credit_card_number
    end

    assert_response :success
    assert same_instance <= 7
  end

  test "#invoice returns the invoice connected to the transaction" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id)

    get :invoice, id: transaction.id, format: :json

    assert_response :success
    assert_equal invoice.customer_id, json_response["customer_id"]
  end
end
