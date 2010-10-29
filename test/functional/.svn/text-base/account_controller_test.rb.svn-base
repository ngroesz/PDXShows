require File.dirname(__FILE__) + '/../test_helper'

class AccountControllerTest < ActionController::TestCase
	def test_login
		bob = users(:bob)
		post :login, :email => bob.email, :password => 'password'
		assert_equal "Login successful.", flash[:notice]
	end
	
	def test_login_with_bad_password
		bob = users(:bob)
		post :login, :email => bob.email, :password => 'incorrect'
		assert_equal "E-mail and password mis-match. (E-mail used: " << bob.email << ")", flash[:error]
	end
end
