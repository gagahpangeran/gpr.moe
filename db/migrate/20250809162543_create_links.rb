class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.string :slug, null: false
      t.string :url
      t.integer :visit_count, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :links, "LOWER(slug)", unique: true
  end
end
