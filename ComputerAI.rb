require './Board'


class ComputerAI


	def initialize theBoard
	
		@theBoard = theBoard
		
		#  there are only 8 ways to win tic-tac-toe.  The ordering of this array is relevant, because this is the order in which the computer will search for "ways to win".  I ordered the array to give precedence to diagonal ways of winning, in order to sway the algorithm towards choosing (more valuable) corner squares over side squares
		@waysToWin = [
			
			#  diagonals
			[1, 5, 9],
			[3, 5, 7],
			
			#  horizontals
			[1, 2, 3],
			[4, 5, 6],
			[7, 8, 9],
			
			#  verticals
			[1, 4, 7],
			[2, 5, 8],
			[3, 6, 9]
		]
		
		#  all combinations of pairs that can lead to a win
		@twoOutOfThree = [
			#  horizontal adjacent pairs
			[1, 2], [2, 3],
			[4, 5], [5, 6],
			[7, 8], [8, 9],

			#  vertical adjacent pairs
			[1, 4], [4, 7],
			[2, 5], [5, 8],
			[3, 6], [6, 9],

			#  diagonal adjacent pairs
			[1, 5], [5, 9],
			[3, 5], [5, 7],
			
			#  opposing horizontal sides
			[1, 3], [4, 6], [7, 9],
			
			#  opposing vertical sides
			[1, 7], [2, 8], [3, 9],
			
			#  opposing diagonal sides
			[1, 9], [3, 7]
		]
	end
	
	def makeMove
		
		#  can I win the game?
		winOrBlockSpot = searchForWinOrBlockSpot "O"
		if winOrBlockSpot then return winOrBlockSpot end
		
		#  do I need to block?
		winOrBlockSpot = searchForWinOrBlockSpot "X"
		if winOrBlockSpot then return winOrBlockSpot end
		
		#  take the most valuable spot (center) if it is available.  This will be the first or second move of the game
		if @theBoard.spotIsAvailable 5 then return 5 end
		
		takeBestSpotThatCanStillWin
	end

	
	
	private
	
	def searchForWinOrBlockSpot marker
	
		@twoOutOfThree.each do |twoOutOfThreePair|
			
			if @theBoard.playerHasBothSpots twoOutOfThreePair, marker
				
				#  retrieve what would be the "win spot" for the pair
				winSpot = getWinSpot twoOutOfThreePair
				
				#  continue searching if the "winSpot" has already been taken
				if !@theBoard.spotIsAvailable winSpot then next end
				
				#  otherwise we want to take the "winSpot"
				return winSpot
			end
		end
		
		#  "marker" doesn't have a "two out of three" pair
		return nil
	end
	
	#  return the "win spot" that corresponds with the given pair
	def getWinSpot twoOutOfThreePair
	
		#  retrieve the "way to win" that is implied by the given twoOutOfThreePair
		wayToWin = @waysToWin.select { |triple| 
										triple.include? twoOutOfThreePair[0] and triple.include? twoOutOfThreePair[1]
									}
		
		#  return the "win spot" from within the "wayToWin".  Remember that wayToWin is an array with only a single item
		winSpot = wayToWin[0].select { |spot| spot != twoOutOfThreePair[0] and spot != twoOutOfThreePair[1]}
		
		#  remember that "winSpot" is an array with a single element
		winSpot[0]
	end
	
	def takeBestSpotThatCanStillWin
	
		@waysToWin.each do |wayToWin|
		
			#  determine if the opponent has any markers in the current "wayToWin"
			opponentMarkersInTheWay = wayToWin.select { |spot| @theBoard.markerHasSpot spot, "X"}
			
			if(opponentMarkersInTheWay.length > 0)
				#  if opponent has a marker in "wayToWin", then move on and search for the next potential "wayToWin"
				
				next
			else
				#  opponent doesn't have a marker in any of the three "wayToWin" spots
				
				return getSpotWithinWayToWin wayToWin
			end
			
		end
		
		#  if execution reaches this point, then there's no way (for the computer) to win the game
		
		takeAnAvailableSpot
		
		
=begin  This isn't the best, it's not intelligent enough to just "take one of the diagonal spots".  The selected spot has to be part of a triad/triple where there is still a chance to win.  Difference between "takeBestSpot" and "takeBestSpotThatCanStillWin"
		#  take one of the diagonal spots
		[1, 3, 5, 7].each do |diagonalSpot| 
			if @theBoard.spotIsAvailable diagonalSpot then return diagonalSpot end
		end
=end

	end
	
	def getSpotWithinWayToWin wayToWin
	
		#  search first without considering the side spots, because they're less desirable/valuable than corner spots
		wayToWinWithCornersOnly = wayToWin - [2, 4, 6, 8]
		
		wayToWinWithCornersOnly.each do |spot| 
			if @theBoard.spotIsAvailable spot then return spot end
		end
		


		#  if execution reaches here then the corner spots have already been taken, so just take one of the side spots
		wayToWin.each do |spot| 
			if @theBoard.spotIsAvailable spot then return spot end
		end
	end
	
	def takeAnAvailableSpot
	
		#  attempt to take a corner spot if available
		[1, 3, 5, 7].each do |spot|
			if @theBoard.spotIsAvailable spot then return spot end
		end
		
		#  take any remaining side spot
		[2, 4, 6, 8].each do |spot|
			if @theBoard.spotIsAvailable spot then return spot end
		end
	end
end
