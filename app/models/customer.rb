class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchant_id = invoices.successful.group(:merchant_id)
                  .order("count_id desc").count("id").first[0]
    Merchant.find(merchant_id)
  end
end
