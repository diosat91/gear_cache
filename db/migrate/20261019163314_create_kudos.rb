class CreateKudos < ActiveRecord::Migration[8.1]
  def change
    create_table :kudos do |t|
      t.references :giver, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.references :booking, foreign_key: true
      t.references :adventure, foreign_key: true

      t.timestamps
    end
  end
end
