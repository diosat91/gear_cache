class CreateGearLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :gear_logs do |t|
      t.references :listing, null: false, foreign_key: true
      t.integer :kind, null: false, default: 0
      t.text :body
      t.date :happened_on

      t.timestamps
    end
  end
end
