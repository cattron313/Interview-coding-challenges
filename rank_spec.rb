# Unit tests for rank.rb (rspec)
require_relative "rank.rb"

# describe Rank, "#rankWord" do
# 	it "returns rank number for a correctly formatted word" do
# 		rankMachine = Rank.new
# 		r1 = rankMachine.rank_word "ABAB"
# 		r2 = rankMachine.rank_word "AaAb"
# 		r3 = rankMachine.rank_word "baaa"
# 		r4 = rankMachine.rank_word "QUESTION"
# 		r5 = rankMachine.rank_word "BOOKKEEPER"
# 		r6 = rankMachine.rank_word "NONINTUITIVENESS"
    	
#     	r1.should.equal(2)
#     	r2.should.equal(1)
#     	r3.should.equal(4)
#     	r4.should.equal(24572)
#     	r5.should.equal(10743)
#     	r6.should.equal(8222334634)
#   	end
# end

describe Integer, "#factorial" do
	it "returns the factorial of a number" do
		0.factorial.should eq(1)
		1.factorial.should eq(1)
		6.factorial.should eq(720)

		expect { -1.factorial }.to raise_error("Can't compute factorials of negative numbers.")
	end
end

describe String, "#number_of_unique_permutations" do
	it "returns the number of unique permutations of a string" do
		"AAAB".number_of_unique_permutations.should eq(4)
		"BAAA".number_of_unique_permutations.should eq(4)
		"ABCD".number_of_unique_permutations.should eq(24)
		"ABAB".number_of_unique_permutations.should eq(6)
	end
end		
