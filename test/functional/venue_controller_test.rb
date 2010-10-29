require File.dirname(__FILE__) + '/../test_helper'

class VenueControllerTest < ActionController::TestCase
	def test_should_display_venue_list
		get :list
		assert_response :success
		assert_template "list"
	end
  
	def test_new_venue_without_user
		get :new
		assert_redirected_to :action => 'login'
	end
	
	def test_new_venue_with_user
		get :new, {}, { :user_id => users(:bob).id }
		assert_response :success
		assert_template 'new'
	end
end
