class RankGenerator
	@@MIN_WORD_SIZE = 2
	@@MAX_WORD_SIZE = 25
	def initialize
		@computedFactorials = [1];
	end

	def rank_word(word)
		# If word is properly formatted...
		# Proper format is a param that is a String with length between 2 and 25 inclusive.
		# Characters must be in the alphabet and uppercase.  I am capitalizing all lowercase letters.
		# There must be at least two different characters.
		if word.is_a? String && word.length >= @@MIN_WORD_SIZE && word.length <= @@MAX_WORD_SIZE && word.match(/^[A-Za-z]+$/)
			word.upcase!
			sorted_array_of_letters = word.split(//).sort
			if (sorted_array_of_letters.uniq.length > 1) # only continue if at least two unique characters
				word.l
			end
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