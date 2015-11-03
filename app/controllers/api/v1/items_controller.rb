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

  private

  def search_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
