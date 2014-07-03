class Game
	def initialize(galaxy)
		
		#initialize variables to keep track of gameplay
		@blast = Blast.new(galaxy["t_per_blast_move"])

		@asteroids = []
		galaxy["asteroids"].each do |val|
			@asteroids << Asteroid.new(val)
		end

		@time = 0
		@ship = Ship.new

	end

	def run(course)
		@gameResult = nil #determines whether you win or lose the game

		#start game
		while gameIsNotOver

			@time++
		end
		return @gameResult
	end

	def gameIsNotOver
		death_by_hitting_home_planet = @ship.position <= -1
		death_by_asteroid = Asteroid.collision(@asteroids, @ship)
		death_by_blast = @blast.collision(@ship)
		return death_by_blast && death_by_asteroid && death_by_hitting_home_planet
	end
end