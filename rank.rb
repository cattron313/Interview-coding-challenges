class RankGenerator
	@@MIN_WORD_SIZE = 2
	@@MAX_WORD_SIZE = 25

	def rank_word(word)
		# If word is properly formatted...
		# Proper format is a param that is a String with length between 2 and 25 inclusive.
		# Characters must be in the alphabet and uppercase.  I am capitalizing all lowercase letters.
		# There must be at least two different characters.
		if word.is_a? String && word.length >= @@MIN_WORD_SIZE && word.length <= @@MAX_WORD_SIZE && word.match(/^[A-Za-z]+$/)
			word.upcase!
			sorted_array_of_letters = word.split(//).sort
			if (sorted_array_of_letters.uniq.length > 1) # only continue if at least two unique characters
				return recursively_rank_word(word, 0, sorted_array_of_letters)
			end
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
		return 1 if sorted_array.empty?
		rank = 0
		index_of_array = 0
		while index_of_array < sorted_array.length
			if word[index_of_word] == sorted_array[index_of_array]
				return recursively_rank_word(word, index_of_word + 1, sorted_array[1, sorted_array.length - 1]) + rank
			else
				rank += sorted_array[1, sorted_array.length - 1].join.number_of_unique_permutations

				# skip over repeated characters in the sorted array to go to next unique character
				while sorted_array[index_of_array] == sorted_array[index_of_array + 1] 
					index_of_array += 1
				end
			end
			index_of_array += 1
		end
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