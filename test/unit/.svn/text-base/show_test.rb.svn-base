require File.dirname(__FILE__) + '/../test_helper'

class ShowTest < ActiveSupport::TestCase
	
	def test_should_require_bands
		s = Show.create(:bands => nil)
		assert s.errors.on(:bands)
	end
	
	def test_should_require_date
		s = Show.create(:date => nil)
		assert s.errors.on(:date)
	end
	
	def test_should_require_venue_id
		s = Show.create(:venue_id => nil)
		assert s.errors.on(:venue_id)
	end
		
	def test_should_create_show
		s = Show.create(
			:bands => 'The Kinks, Modest Mouse',
			:venue_id => '1',
			:date => '2009-04-28')
		assert s.valid?
	end
end
