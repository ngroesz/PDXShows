require "#{File.dirname(__FILE__)}/../test_helper"
class ShowTest < ActionController::IntegrationTest
	fixtures :shows, :users, :venues
	def test_show_submission_with_login
		get '/show/new'
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_template 'account/login'
		post '/account/login', :email => 'bob@aol.com',
			:password => 'password'
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_template 'show/new'
		post 'show/new', :show => {
			:bands => 'The Clash, The Who, The Stooges',
			:date => '2009-06-09',
			:venue_id => '1'
		}
		assert_response :redirect
		follow_redirect!
		assert_response :success
		assert_template 'show/list'
	end
end

