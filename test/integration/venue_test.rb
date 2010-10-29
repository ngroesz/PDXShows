require "#{File.dirname(__FILE__)}/../test_helper"
class VenueTest < ActionController::IntegrationTest
	fixtures :users, :venues
	def test_venue_submission_with_login
		get '/venue/new'
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_template 'account/login'
		post '/account/login', :email => 'bob@aol.com',
			:password => 'password'
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_template 'venue/new'
		post 'venue/new', :venue => {
			:name => 'The Roseland',
			:address => '500 East Burnside',
			:start_time => '21:00:00',
			:notes => 'Big Venue'
		}
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_template 'venue/list'
	end
end
