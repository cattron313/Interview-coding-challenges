class RankGenerator
	@@MIN_WORD_SIZE = 2
	@@MAX_WORD_SIZE = 25
	def initialize
		@computedFactorials = [1];
	end

	def rankWord(word)
		# If word is properly formatted...
		# Proper format is a param that is a String with length between 2 and 25 inclusive.
		# Characters must be in the alphabet and capitalized.  I am capitalizing all lower case letters.
		if word.is_a?String && word.length >= @@MIN_WORD_SIZE && word.length <= @@MAX_WORD_SIZE && word.match(/^[A-Za-z]+$/)
			word.upcase!
			
		end
	end
end