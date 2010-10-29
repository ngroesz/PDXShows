require File.dirname(__FILE__) + '/../test_helper'

class VenueTest < ActiveSupport::TestCase
  def test_should_require_name
		v = Venue.create(:name => nil)
		assert v.errors.on(:name)
	end
	
	def test_should_require_address
		v = Venue.create(:address => nil)
		assert v.errors.on(:address)
	end
end
