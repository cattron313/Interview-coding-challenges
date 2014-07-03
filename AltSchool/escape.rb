require 'net/http'
require 'json'
require 'curb'

def recursivelyEscape(course, position)
	puts "#{course}, POSITION #{position}"
	if !(result = attemptToEscape(course)).is_a?(Hash) && result
		puts "FINAL #{course}"
		return
	else
		if result[:a] == 0
			(result[:t] - course.length - 1).times { |i| course << 0 }
			recursivelyEscape(course << 1, result[:p])
		elsif result[:a] == 1
			if course[-1] == -1
				(course.length - 1).downto(0) do |n|
					if course[n] == 0
						course[n] = -1
						break
					end
				end
				recursivelyEscape(course << 1, result[:p])
			else
				course[-1] = -1
				recursivelyEscape(course, result[:p])
			end
		else
			# course.delete_at(-1)
			(course.length - 1).downto(0) do |n|
				if course[n] == 0
					course[n] = 1
					break
				end
			end
			recursivelyEscape(course, result[:p])
		end
	end
end

#Run the curl command to see if ship escaped
def attemptToEscape(course)
	http = Curl.post("http://eschaton.herokuapp.com", course.to_json)
	array_of_lines = http.body_str.split(/\r?\n/)  #split retunred text by lines
	result = array_of_lines[-1] == "true" ? true : get_acceleration_and_position_and_time(array_of_lines)
	puts "#{result}"
	return result
end

def get_acceleration_and_position_and_time(aol)
	return {p: aol[-2][/p=\d+/][/\d+/].to_i, a: aol[-4][/a=-?\d+/][/-?\d+/].to_i, t: aol[-3][/t=\d+/][/\d+/].to_i}
end

recursivelyEscape([1,1], -1)