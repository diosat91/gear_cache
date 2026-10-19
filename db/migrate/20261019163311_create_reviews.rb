class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :reviewer, null: false, foreign_key: { to_table: :users }
      t.references :reviewee, null: false, foreign_key: { to_table: :users }
      t.integer :rating, null: false
      t.text :body

      t.timestamps
    end

    add_index :reviews, [:booking_id, :reviewer_id], unique: true
  end
end
