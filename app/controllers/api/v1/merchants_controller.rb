class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(search_params)
  end

  def find
    respond_with Merchant.find_by(search_params)
  end

  def find_all
    respond_with Merchant.where(search_params)
  end

  def random
    respond_with Merchant.order("RANDOM()").first
  end

  def items
    respond_with Merchant.find_by(search_params).items
  end

  def invoices
    respond_with Merchant.find_by(search_params).invoices
  end

  private

  def search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
