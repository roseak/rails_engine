require "csv"

namespace :import_transactions_csv do
  task create_transactions: :environment do
    csv_data = File.read("public/transactions.csv")
    csv = CSV.parse(csv_data, headers: true)
    csv.each do |row|
      Transaction.create(row.to_hash.except("credit_card_expiration_date"))
    end
  end
end
