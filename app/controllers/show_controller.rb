require 'lib/show_calendar.rb'

class ShowController < ApplicationController
	before_filter :login_required, :only => :new
	
	def detail 
		# we provide a link to the last list viewed
		@back_link = session[:list_link]
		
		@show = Show.find_by_id(params[:id])
		@my_show = is_in_my_shows(@show.id)
	end
	
	def list
		# keep track of the latest list link used
		session[:list_link] = request.request_uri	
		
		if params[:type] == 'upcoming'
			list_upcoming_shows
		elsif params[:type] == 'my_shows'
			list_my_shows
		else
			raise("Unknown list type \"#{params[:type]}\"")
		end
	end
	
	def list_upcoming_shows
		@title = 'Upcoming Shows'
		
		@date = Time.now.strftime("%Y-%m-%d") 
		@shows = Show.find(:all,
			:order => 'date, bands',
			:conditions => "date >= \"#{@date}\"")
		@venues = Venue.find(:all)
		
		@my_shows = Hash.new
		@shows.each do |show|
			if is_in_my_shows(show.id)
				@my_shows[show.id] = 'yes'
			else 
				@my_shows[show.id] = 'no'
			end
		end		
	end
	
	def list_my_shows
		unless @current_user.nil?
			date = Time.now.strftime("%Y-%m-%d") 

			@title = 'My Shows'
			@shows = Show.find(:all,
				:conditions => "my_shows.user_id = #{@current_user.id} AND shows.date >= \"#{date}\"",
				:joins => "JOIN my_shows ON shows.id = my_shows.show_id",
				:order => 'date, bands')
			@venues = Venue.find(:all)
		end
	end
	
	def new
		@venues = Venue.find(:all, :order => 'name').map {|v| [v.name, v.id] }
		@current_year = Time.now.year
		
		if(request.post?)
			@show = Show.new(params[:show])
			if(@show.save)
				redirect_to(:action => 'list', :type => 'upcoming')
			else 
				render(:action => 'new')
			end
		end
	end 
	
	def add_my_show
		@show_id = params[:id].to_i
		if (@show_id > 0 && !@current_user.nil?)
			unless (is_in_my_shows(@show_id))
				@my_show = MyShow.new
				@my_show.show_id = @show_id
				@my_show.user_id = @current_user.id
				@my_show.save
			end
		end
		# don't redirect if we got an Ajax request
		return if request.xhr?
		
		if params[:from] == 'show_list'
			redirect_to(:action => 'list', :type => 'upcoming')
		else 
			redirect_to(:action => 'detail', :id => @show_id)
		end
	end
		
	def is_in_my_shows(show_id)
		
		@existing = nil;
		
		unless @current_user.nil?
			@show_id = show_id.to_i
			@existing = MyShow.find(:first, 
									:conditions => ["show_id = :show_id AND user_id = :user_id",
													{:show_id => @show_id, :user_id => @current_user.id}])
		end
		
		if @existing
			return true
		else 
			return false
		end
	end
	
	def generate_calendar
		if @current_user.nil? || params[:type] == 'upcoming'
			cal = ShowCalendar.new(nil)
		else 
			cal = ShowCalendar.new(@current_user)
		end
		send_data(cal.generate, :filename => 'shows.ics')
	end
end

