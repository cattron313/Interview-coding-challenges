# To execute this program please type
# ruby {path to file rank.rb} {word}
# into your console

# Tested on Ruby 2.0.0

class RankCalculator
	@@MIN_WORD_SIZE = 2
	@@MAX_WORD_SIZE = 25
	@@INPUT_ERROR = "Input argument must be an alphabetic string between 2 and 25 chracters long with at least two unique characters." 

	def rank_word(word)
		# If word is properly formatted...
		# Proper format is a param that is a String with length between 2 and 25 inclusive.
		# Characters must be in the alphabet and uppercase.  I am capitalizing all lowercase letters.
		# There must be at least two different characters.
		if word.is_a?(String) && word.length >= @@MIN_WORD_SIZE && word.length <= @@MAX_WORD_SIZE && word.match(/^[A-Za-z]+$/)
			word = word.dup
			word.upcase!
			sorted_array_of_letters = word.split(//).sort
			if (sorted_array_of_letters.uniq.length > 1) # only continue if at least two unique characters
				puts "Start recursive call..." if $DEBUG
				answer = recursively_rank_word(word, 0, sorted_array_of_letters)
				puts answer
				return answer
			else
				raise @@INPUT_ERROR
			end
		else
			raise @@INPUT_ERROR
		end
	end

	private
	# ALGORITHM
	# Sort array of letters alphabetically.  Loop through array.  Start with first letter in the word.
	# If letter in word is equal to letter in the array, recursively calculate rank by removing the first element
	# in the sorted array and incrementing the index of the word. Return the results of that recursive call plus the current rank.
	# If not, calculate rank of letters in a subarray that removes the first character of the sorted array and
	# sum with existing rank.  Increment array index to skip over repeated characters in sorted array.
	def recursively_rank_word(word, index_of_word, sorted_array)
		if $DEBUG
			puts "---------"
			puts "WORD:#{word[index_of_word..word.length-1]}"
			puts "IOW:#{index_of_word}"
			puts "SORTED_ARRAY:#{sorted_array}"
		end

		return 1 if sorted_array.empty?
		rank = 0
		index_of_array = 0
		while index_of_array < sorted_array.length
			if $DEBUG
				puts "RANK:#{rank}"
				puts "IOA:#{index_of_array}"
			end
			sliced_array = Array.new(sorted_array)
			sliced_array.delete_at(index_of_array) # array without the element at the current index
			puts "SLICED_ARRAY:#{sliced_array}" if $DEBUG
			if word[index_of_word] == sorted_array[index_of_array]
				puts "Match #{word[index_of_word]}" if $DEBUG
				sliced_array
				return recursively_rank_word(word, index_of_word + 1, sliced_array) + rank
			else
				puts "No match" if $DEBUG
				rank += sliced_array.join.number_of_unique_permutations

				# skip over repeated characters in the sorted array to go to next unique character
				puts "Skipping over repeated characters..." if $DEBUG
				while sorted_array[index_of_array] == sorted_array[index_of_array + 1] 
					index_of_array += 1
				end
			end
			index_of_array += 1
		end
		return rank
	end
end

class Integer < Numeric
	def factorial
		if self < 0
			raise "Can't compute factorials of negative numbers."
		elsif self > 0
			return (1..self).inject(:*)
		else
			return 1
		end
	end
end

class String < Object
	def number_of_unique_permutations
		characters_hash = {}
		repeated_characters_product = 1

		self.each_char do |c|
			# count how many times each character appears
			characters_hash[c] = characters_hash.has_key?(c) ? characters_hash[c] + 1 : 1
		end

		characters_hash.each_value do |val|
			if val > 1
				repeated_characters_product *= val.factorial
			end
		end

		# To find unique permutations you need to take the total number of permutations possible (n!)
		# divided by the product of all factorials of repeated charcters
		return self.length.factorial / repeated_characters_product
	end
end

RankCalculator.new.rank_word ARGV[0]