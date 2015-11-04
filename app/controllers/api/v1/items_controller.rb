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

  def invoice_items
    respond_with InvoiceItem.where(item_id: params[:id])
  end

  def merchant
    respond_with Item.find_by(search_params).merchant
  end

  def most_revenue
    respond_with Item.most_revenue(params)
  end

  def most_items
    respond_with Item.most_items(params)
  end

  def best_day
    respond_with best_day: Item.find(params[:id]).best_day
  end

  private

  def search_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
