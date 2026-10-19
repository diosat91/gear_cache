class AddCurrencyToListingsAndBookings < ActiveRecord::Migration[8.1]
  def change
    add_column :listings, :currency, :string, null: false, default: "EUR"
    add_column :bookings, :currency, :string, null: false, default: "EUR"
  end
end
