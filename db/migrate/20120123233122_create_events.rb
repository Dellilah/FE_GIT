class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :city
      t.string :street
      t.integer :building_number
      t.boolean :confirmation, :default => false
      t.integer :door_number
      t.date :stop_date
      t.datetime :start_date
      t.boolean :reminded, :default => false
      t.references :category

      t.timestamps
    end
    add_index :events, :category_id
    add_column :events, :latitude, :float #you can change the name, see wiki
add_column :events, :longitude, :float #you can change the name, see wiki
add_column :events, :gmaps, :boolean #not mandatory, see wiki
  def self.down
    drop_table :events
  end
  end
  
end
