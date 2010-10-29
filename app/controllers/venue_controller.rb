class VenueController < ApplicationController
	before_filter :login_required, :only => :new
	
	def detail
		@venue = Venue.find(params[:id])
	end
	
	def new
		@venue = Venue.new(params[:venue])
		@venue.start_time = "20:00:00"
		if request.post? and @venue.save
			redirect_to :action => 'list'
		else 
			render :action => 'new'
		end
	end
	
	def list
		@venues = Venue.find(:all,
			:order => 'name')
	end
end
