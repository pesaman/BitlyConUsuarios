class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string :name
        t.string :email
        t.string :password
    end
    create_table :urls do |t|
      t.belongs_to :user, index: true
      t.string :long_url
      t.string :short_url
      t.integer :click_count, :default => 0
      t.timestamps
    end
  end
end