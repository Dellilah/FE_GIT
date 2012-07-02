class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :name
      t.string :surname
      t.string :crypted_password
      t.boolean :admin, :default => false
      t.boolean :moderator, :default => false
      t.string :persistence_token
      t.string :avatar_url
            
      t.timestamps
    end
    
    create_table :visibilities do |t|
      t.boolean :email
      t.boolean :name
      t.boolean :surname
      t.boolean :avatar_url
      t.boolean :events
      t.references :user

      t.timestamps
    end
  end
end
