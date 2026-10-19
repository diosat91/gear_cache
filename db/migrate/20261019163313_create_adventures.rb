class CreateAdventures < ActiveRecord::Migration[8.1]
  def change
    create_table :adventures do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.string :location_text
      t.date :happened_on

      t.timestamps
    end
  end
end
