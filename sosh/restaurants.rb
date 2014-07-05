# Load file into irb and you should be good to go!
require "date"

def find_open_restaurants(filename, datetime)
	raise "Invalid input.  Please enter in a filename and a datetime object" unless File.file?(filename) && datetime.is_a?(DateTime)

	restaurant_list = parse_csv_file(filename) # parse file into data structure
	open_restaurants = []
	restaurant_list.each do |restaurant| # loop through restaurants
		if restaurant[:hours][datetime.cwday] &&
			datetime.total_seconds_from_midnight >= restaurant[:hours][datetime.cwday][:open] &&
			datetime.total_seconds_from_midnight < restaurant[:hours][datetime.cwday][:close]
			# store is open
			open_restaurants << restaurant[:name]
		end
	end
	return open_restaurants
end

def parse_csv_file(filename)
	result = []
	File.open(filename, "r") do |file|
		while (line = file.gets)
			line.strip!
			line = line[1..line.length - 2] # remove leading and trailing quotes

			line = line.split('","')
			result << { name: line[0], hours: extract_and_parse_hours(line[1]) }
		end
	end
	return result
end

def extract_and_parse_hours(str)
	result = {}
	str.split('/').each do |hours_info|
		index_of_first_digit = hours_info.index(/[0-9]/)

		time_range = hours_info[index_of_first_digit..hours_info.length-1].split("-") # open and close times
		days = hours_info[0..index_of_first_digit - 1].split(",")

		days.each do |day_info|
			first_day, last_day = 0
			if index_of_dash = day_info.index("-")
				# loop through days range and add times
				first_day = numerical_key_for_day(day_info[index_of_dash - 3, 3]) # first day of range is 3 characters before "-"
				last_day = numerical_key_for_day(day_info[index_of_dash + 1, 3])# last day of range is the next 3 characters after "-"
			else					
				# add time for a single day
				first_day = numerical_key_for_day(day_info.strip)
				last_day = first_day
			end
			while first_day <= last_day
				result[first_day] = {open: parse_time(time_range[0].strip), close: parse_time(time_range[1].strip)}
				result[first_day][:close] += 24 * 60 * 60 if result[first_day][:close] < result[first_day][:open] # if the closed time is smaller than the open time, then we need to increment the closed time by 1 day
				first_day += 1
			end
		end
	end
	return result
end

def numerical_key_for_day(day)
	case day
	when "Mon"
		return 1
	when "Tue"
		return 2
	when "Wed"
		return 3
	when "Thu"
		return 4
	when "Fri"
		return 5
	when "Sat"
		return 6
	when "Sun"
		return 7
	else
		raise "Invalid day in CSV file."
	end
end

def parse_time(time_str)
	# returns the total time in seconds with 12am equaling 0 seconds
	index = time_str.index(":")
	min = index ? time_str[index + 1, 2].to_i : 0
	hr = index ? time_str[0..index - 1].to_i : time_str[/[0-9]+/].to_i
	if hr >= 1 && hr <= 11 && time_str["pm"] 
		hr += 12 
	elsif hr == 12 && time_str["am"]
		hr = 0
	end
	return hr * 60 * 60 + min * 60
end

class DateTime < Date
	def total_seconds_from_midnight
		# returns just the total seconds from midnight (doesn't include any fractional seconds)
		return self.hour * 60 * 60 + self.min * 60 + self.sec
	end
end