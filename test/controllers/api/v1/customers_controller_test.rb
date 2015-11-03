require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json
    assert_response :success
  end

  test "#show" do
    get :show, format: :json
  end
end
