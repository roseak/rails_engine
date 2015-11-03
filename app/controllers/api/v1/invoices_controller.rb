class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find(params[:id])
  end

  def find
    respond_wth Invoice.find_by(search_params)
  end

  private

  def search_params
    params.permit(:customer_id, :merchant_id, :status)
  end
end
