require 'rubygems'
require 'icalendar'
require 'date'



class ShowCalendar
	include Icalendar
	
	def initialize(user)
		@user = user
	end
	
	def generate
		@cal = Calendar.new
		date = Time.now.strftime("%Y-%m-%d") 
		
		if @user.nil?		
			shows = Show.find(:all,
				:order => 'date',
				:conditions => "date >= \"#{date}\"")
		else
			shows = Show.find(:all,
				:conditions => "my_shows.user_id = #{@user.id} AND date >= \"#{date}\"",
				:joins => "JOIN my_shows ON shows.id = my_shows.show_id",
				:order => 'date')
		end
		
		shows.each do |show|
			add_show(show)
		end
	
		return @cal.to_ical
	end
	
	def add_show(show)
		venue = Venue.find(show.venue_id)

		event = Event.new
		event.start = show.date
		event.summary = show.bands
		event.location = "#{venue.name}" unless venue.nil?
		event.location += " at #{venue.address}" unless venue.address.nil?
		
		event.description = "Bands: #{show.bands}\n"
		event.description += "Notes: #{show.notes}\n"	unless show.notes.nil?
		
		event.description += "\nCurrent Information at PDXShows: http://localhost:3000/show/detail/#{show.id}"
		@cal.add_event(event)
	end		
end
