class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :renter, null: false, foreign_key: { to_table: :users }
      t.date :start_on, null: false
      t.date :end_on, null: false
      t.integer :status, null: false, default: 0
      t.integer :daily_rate_cents
      t.integer :days
      t.integer :subtotal_cents
      t.integer :deposit_cents
      t.datetime :approved_at
      t.datetime :declined_at
      t.datetime :picked_up_at
      t.datetime :returned_at
      t.datetime :cancelled_at

      t.timestamps
    end
  end
end
