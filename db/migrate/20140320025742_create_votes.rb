class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :email
      t.integer :link1
      t.integer :link2
      t.integer :link3
      t.integer :link4
      t.integer :link5
      t.integer :date1
      t.integer :date2
      t.integer :date3
      t.boolean :confirmed
      t.references :event, index: true
      
      t.timestamps
    end
  end
end
