class Item < ActiveRecord::Base
  before_save :unit_price_to_dollars
  belongs_to :merchant
  has_many :invoice_items

  def unit_price_to_dollars
    self.unit_price = self.unit_price/100
  end
end
