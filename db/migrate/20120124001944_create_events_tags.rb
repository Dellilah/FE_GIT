class CreateEventsTags < ActiveRecord::Migration
  def self.up
  	create_table :events_tags, :id => false do |t|
      t.references :event
      t.references :tag
    end
    add_index :events_tags, [:event_id, :tag_id], :unique => true
  end

  def self.down
  	drop_table :events_tags
  end
end
