class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date
      t.datetime :cutoff_at
      t.string :link1
      t.string :name1
      t.string :link2
      t.string :name2
      t.string :link3
      t.string :name3
      t.string :link4
      t.string :name4
      t.string :link5
      t.string :name5
      t.datetime :date1
      t.datetime :date2
      t.datetime :date3
      t.string :unique_id
      t.string :organiser_email
      t.string :organiser_name

      t.timestamps
    end
  end
end
