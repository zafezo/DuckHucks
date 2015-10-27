class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :event_id
      t.string :name

      t.timestamps null: false
    end
  end
end
