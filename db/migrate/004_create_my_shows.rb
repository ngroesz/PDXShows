class CreateMyShows < ActiveRecord::Migration
  def self.up
    create_table :my_shows, :id=> false do |t|
		t.column :show_id, :integer
		t.column :user_id, :integer
		t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :my_shows
  end
end
