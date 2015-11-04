class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def find_revenue(params)
    if params[:date]
      revenue_with_date(params[:date])
    else
      revenue
    end
  end

  def self.total_merchants_revenue(params)
    Invoice.successful.by_date(params[:date]).joins(:invoice_items).sum("quantity * unit_price")
  end

  def revenue
    invoices.successful.joins(:invoice_items).sum("quantity * unit_price")
  end

  def items_sold
    invoices.successful.joins(:invoice_items).sum("quantity")
  end

  def revenue_with_date(date)
    invoices.successful.by_date(date).joins(:invoice_items).sum("quantity * unit_price")
  end

  def favorite_customer
    customer_id = invoices.successful.group(:customer_id).order("count_id desc").count("id").first[0]
    Customer.find(customer_id)
  end

  def customers_with_pending_invoices
    invoices.pending.map(&:customer).uniq
  end

  def self.most_revenue(params)
    all.sort_by(&:revenue).reverse.first(params[:quantity].to_i)
  end

  def self.most_items(params)
    all.sort_by(&:items_sold).reverse.first(params[:quantity].to_i)
  end
end
