class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.column :name, :string
      t.column :address, :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :start_time, :time
      t.column :notes, :text
    end
    add_column :shows, :venue_id, :integer 
  end

  def self.down
    drop_table :venues
    remove_column :shows, :venue_id
  end
end
