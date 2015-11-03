class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end

  def find
    respond_with Item.find_by(search_params)
  end

  def find_all
    respond_with Item.where(search_params)
  end

  def random
    respond_with Item.order("RANDOM()").first
  end


  private

  def search_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
