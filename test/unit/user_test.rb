require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  
	def test_should_require_email
		u = User.create(:email => nil)
		assert u.errors.on(:email)
	end
	
	def test_should_require_password
		u = User.create(:password => nil)
		assert u.errors.on(:password)
	end
end
