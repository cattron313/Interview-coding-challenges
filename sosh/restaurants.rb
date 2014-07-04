def find_open_restaurants(filename, datetime)
	if !File.file?(filename)
	end

	restaurant_list = parse_csv_file(filename) #parse file into data structure
	open_restaurants = []
	restaurant_list.each do |restaurant| # loop through restaurants
		if datetime.to_time >= restaurant.hours[datetime.cwday][:open] &&
			datetime.to_time < restaurant.hours[datetime.cwday][:close]
			# store is open
			open_restaurants << restaurant.name
		end
	end
	return open_restaurants
end

def parse_csv_file(filename)
	result = []
	File.open(filename, "r") do |file|
		while (line = file.gets)
			line.strip!
			line = line[1..line.length - 2] #remove leading and trailing quotes
			line = line.split('","')
			result << { name: line[0] }
			puts line
		end
	end
	return result
end