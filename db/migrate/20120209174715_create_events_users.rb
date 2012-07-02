class CreateEventsUsers < ActiveRecord::Migration
  def up
  	  create_table :events_users, :id => false do |t|
      t.references :event
      t.references :user
      
    end
  add_index :events_users, [:event_id, :user_id], :unique => true
  end

  def down
  	drop_table :events_users
  end
end
