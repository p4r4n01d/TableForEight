class AddOrganiserToEvents < ActiveRecord::Migration
  def change
    add_column :events, :email, :string
    add_column :events, :organiser_name, :string
  end
end
