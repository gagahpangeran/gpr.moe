class CreateDailyVisits < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_visits do |t|
      t.references :link, null: false, foreign_key: true
      t.date :visited_at, null: false
      t.integer :count, null: false, default: 0

      t.timestamps
    end
  end
end
