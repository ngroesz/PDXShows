class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
		  t.column :bands, :string
     	t.column :date, :date
			t.column :created_at, :datetime
			t.column :updated_at, :datetime
			t.column :notes, :text
		end
  end

  def self.down
    drop_table :shows
  end
end
