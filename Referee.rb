

class Referee

	def initialize theBoard
		@theBoard = theBoard
		@spotsOnBoard = theBoard.spotsOnBoard
	end

	def thereIsAWinner marker
		
		
		if someoneHasWon marker then 
			puts "Congratulations!  #{marker} has won the game!" 
			return true
		end 
		
		return false
	end
	
	def boardIsFilledUp
	
		if @theBoard.noSpotsLeft then
			puts "CAT!  Game ends in a tie"
			return true
		end
		
		false
	end
	
	
	private
	
	def someoneHasWon marker
	
		hasWon = false
	
		if @spotsOnBoard[1] == marker
			#  spot 1 is taken by the marker ...
		
			#  ... we need to check for 1-2-3, 1-5-9 and 1-4-7
			hasWon = 
				(@spotsOnBoard[2] == marker && @spotsOnBoard[3] == marker) ||
				(@spotsOnBoard[5] == marker && @spotsOnBoard[9] == marker) ||
				(@spotsOnBoard[4] == marker && @spotsOnBoard[7] == marker)
				
			return true if hasWon == true
		end
		
		if @spotsOnBoard[2] == marker
			#  spot 2 is taken by the marker ...
			
			#  we need to check for 2-5-8
			hasWon = @spotsOnBoard[5] == marker && @spotsOnBoard[8] == marker
			
			return true if hasWon == true
		end
		
		if @spotsOnBoard[3] == marker
			#  spot 3 is taken by the marker ...
			
			#  ... we need to check for 3-5-7 and 3-6-9
			hasWon = 
				(@spotsOnBoard[5] == marker && @spotsOnBoard[7] == marker) ||
				(@spotsOnBoard[6] == marker && @spotsOnBoard[9] == marker)
				
			return true if hasWon == true
		end
		
		if @spotsOnBoard[4] == marker
			
			#  we need to check for 4-5-6
			hasWon = @spotsOnBoard[5] == marker && @spotsOnBoard[6] == marker
			
			return true if hasWon == true
		end
		
		if @spotsOnBoard[7] == marker
		
			#  we need to check for 7-8-9
			hasWon = @spotsOnBoard[8] == marker && @spotsOnBoard[9] == marker
			
			return true if hasWon == true
		end
		
		false
	end
	
end