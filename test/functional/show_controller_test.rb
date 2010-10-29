require File.dirname(__FILE__) + '/../test_helper'

class ShowControllerTest < ActionController::TestCase
	fixtures :shows, :venues
	
	#def setup
	#	@controller = ShowController.new
	#	@request = ActionController::TestRequest.new
	#	@response = ActionController::TestResponse.new
	#end
	def test_should_display_upcoming_list
		get :list, :type => 'upcoming'
		assert_response :success
		assert_template "list"
	end
	
	def test_new_show_without_user
		get :new
		assert_redirected_to :action => 'login'
	end
	
	def test_new_show_with_usser
		get :new, {}, { :user_id => users(:bob).id }
		assert_response :success
		assert_template "new"
	end
end
