

class Board
	
	attr_accessor :spotsOnBoard
	
	def initialize
	
		#  maps the coordinates with the names of each spot on the board
		@mappings = {
			1 => "1,1", 2 => "5,1", 3 => "9,1",
			4 => "1,5", 5 => "5,5", 6 => "9,5",
			7 => "1,9", 8 => "5,9", 9 => "9,9"
		}

		#  this attribute contains which spots are marked with Xs and Os
		@spotsOnBoard = {
			1 => "1", 2 => "2", 3 => "3",
			4 => "4", 5 => "5", 6 => "6",
			7 => "7", 8 => "8", 9 => "9"
		}
	end
	
	def selectedSpotIsValid selectedSpot
	
		(1..9).include? selectedSpot
	end
	
	def spotIsAvailable selectedSpot
	
		!@spotsOnBoard[selectedSpot].include? "X" and !@spotsOnBoard[selectedSpot].include? "O"
	end
	
	
	def markerHasSpot selectedSpot, marker
	
		@spotsOnBoard[selectedSpot] == marker
	end
	
	def markerTakesSpot selectedSpot, marker

		if !spotIsAvailable selectedSpot then 
			raise Error, "The Board is attempting to mark a spot that has already been taken" 
		end
	
		#  mark the selected spot on the board
		@spotsOnBoard[selectedSpot] = marker
	end
	
	
	def playerHasBothSpots spots, marker
		
		return @spotsOnBoard[spots[0]] == marker && @spotsOnBoard[spots[1]] == marker
	end
	
	def noSpotsLeft
	
		emptySpots = @spotsOnBoard.select { |spot, value| value != "X" and value != "O"}
		emptySpots.length == 0
	end
	
	#  print out the tic-tac toe board
	def printBoard

		puts

		#  print out 10 rows
		(0..10).each { |rowIndex| printRow rowIndex}

	end


	
	private
	
	#  print out an individual row of the Tic-Tac-Toe board
	def printRow(rowIndex)

		#  left padding
		print "   "

		(0..10).each { |columnIndex|
			#  each column index ...
			
			#  output horizontal line at rows 3 and 7
			if rowIndex == 3 || rowIndex == 7 then print "-"
			
			#  output vertical lines at columns 3 and 7
			elsif columnIndex == 3 || columnIndex == 7 then print "|" 
			
			
			elsif [1, 5, 9].include? columnIndex and [1, 5, 9].include? rowIndex then
				#  we are at a X, O, or # location ...
				
				
				#  output the value from @mappings at the current spot (will be X, O or a number)
				currSpot = @mappings.key "#{columnIndex},#{rowIndex}"
				print @spotsOnBoard[currSpot]
				
			#  all other spots on the grid are just a blank space
			else print " "
			end
		}

		puts
	end

end