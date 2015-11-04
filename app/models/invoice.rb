class Invoice < ActiveRecord::Base
  scope :successful, -> { joins(:transactions).where(transactions: {result: "success"}) }
  scope :pending, -> { joins(:transactions).where(transactions: {result: "failed"}) }
  scope :by_date, -> (date) { where(created_at: date)}

  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
end
