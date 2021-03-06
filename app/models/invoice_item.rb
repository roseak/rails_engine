class InvoiceItem < ActiveRecord::Base
  scope :successful, -> { joins(:invoice).merge(Invoice.successful) }

  before_save :unit_price_to_dollars
  belongs_to :item
  belongs_to :invoice

  def unit_price_to_dollars
    self.unit_price = self.unit_price/100
  end
end
