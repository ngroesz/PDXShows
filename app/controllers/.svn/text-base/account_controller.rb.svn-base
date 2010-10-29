class AccountController < ApplicationController
	def login
		if (request.post?) 
			@current_user = User.find_by_email_and_password(params[:email], params[:password])
			unless @current_user.nil?
				session[:user_id] = @current_user.id
				if (session[:return_to])
					redirect_to session[:return_to]
					session[:return_to] = nil
				else 
					redirect_to :controller => 'show',
								:action => 'list',
								:type => 'upcoming'
				end
				flash[:notice] = 'Login successful.'						
			else 
				flash[:error] = "E-mail and password mis-match. (E-mail used: #{params[:email]})"
			end
		end
	end
	
	def logout
		flash[:notice] = 'You have logged out.'
		session[:user_id] = @current_user = nil
		redirect_to :controller => 'show'
	end
	
	def signup
		@user = User.new(params[:user])
		if (request.post? and @user.save)
			params[:email] = @user.email
			params[:password] = @user.password
			login
		end
	end
end
