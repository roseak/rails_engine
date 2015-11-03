class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find(params[:id])
  end

  def find
    respond_with InvoiceItem.find_by(search_params)
  end

  private

  def search_params
    params.permit(:item_id, :invoice_id, :unit_price, :quantity)
  end
end
