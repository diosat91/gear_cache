class CreateListings < ActiveRecord::Migration[8.1]
  def change
    create_table :listings do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :category, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :brand
      t.integer :condition, null: false, default: 0
      t.boolean :safety_critical, null: false, default: false
      t.integer :price_per_day_cents, null: false, default: 0
      t.integer :deposit_cents, null: false, default: 0
      t.string :location_text, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
