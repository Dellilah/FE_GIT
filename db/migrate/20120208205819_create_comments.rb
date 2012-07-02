class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :content
      t.text :difference, :default => ''
      t.references :user
      t.references :event

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :event_id
  def self.down
    drop_table :comments
  end
  end
end
