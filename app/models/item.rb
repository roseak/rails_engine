class Item < ActiveRecord::Base
  before_save :unit_price_to_dollars
  belongs_to :merchant
  has_many :invoice_items

  def unit_price_to_dollars
    self.unit_price = self.unit_price/100
  end

  def self.most_revenue(params)
    InvoiceItem.successful.group(:item).sum("quantity * unit_price").sort_by(&:last).last(params[:quantity].to_i).reverse.map(&:first)
  end
end
