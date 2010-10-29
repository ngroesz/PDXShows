# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def display_show_date(date)
		date.strftime("%B %d, %Y")
	end
	
	def display_start_time(time)
		t = time.strftime("%I:%M %p")
		# remove leading zero
		t = t.sub(/^0/,'')
		return t
	end
end
