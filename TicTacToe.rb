require './Board'
require './Referee'
require './ComputerAI'

class TicTacToe


	def PlayGame
	
		@theBoard = Board.new
		
		#  both the Referee and the computer AI need to have a reference to the Board class
		@referee = Referee.new @theBoard
		@computerAI = ComputerAI.new @theBoard
	
		#  print the board at the very start of the game
		@theBoard.printBoard

		printWelcomeMessage

		if playerWillGoFirst
			#  this array stores references to method calls
			turns = [lambda { playerTurn }, lambda { computerTurn }]
		else
			turns = [lambda { computerTurn }, lambda { playerTurn }]
		end
		
		while true
			#  the game loop

			#  the first player's turn, exit if the user wants to quit
			if turns[0].call == false then break end
			
			#  print board after the first player has moved
			@theBoard.printBoard

			if @referee.thereIsAWinner "X" then break end
			if @referee.thereIsAWinner "O" then break end
			if @referee.boardIsFilledUp then break end
			
			#  the second player's turn, exit if the user wants to quit
			if turns[1].call == false then break end

			#  print board after the second player's turn
			@theBoard.printBoard

			
			if @referee.thereIsAWinner "X" then break end
			if @referee.thereIsAWinner "O" then break end
			if @referee.boardIsFilledUp then break end
		end
		
	end


	


	private
	
	def printWelcomeMessage
		puts "Let's play Tic-Tac-Toe!\n" \
			"You will be X\n" \
			"Computer will be O\n"
	end

	def playerWillGoFirst
	
		puts "Would you like to go first?  (Y or N)"
		goFirst = gets
		
		goFirst.strip!
		
		#  user entered in y or yes
		goFirst =~ /^y(es)?$/i
	end

	def playerTurn

		
		while true
			#  this loop runs as long as the user hasn't quit or entered in a valid spot to move to
		
			puts "Where would you like to move?  (Press Q to quit)"
			userSpot = gets 

			if playerWantsToQuit userSpot then 
				puts "Goodbye - Thanks for playing"
				return false 
			end

			#  convert to integer
			selectedSpot = userSpot.to_i

			
			if !@theBoard.selectedSpotIsValid selectedSpot
				puts "Please enter in a spot between 1-9"
			elsif !@theBoard.spotIsAvailable selectedSpot
				puts "Space #{selectedSpot} is already taken "
			else
				@theBoard.markerTakesSpot selectedSpot, "X"
				break
			end
			
		end
		
	end

	def computerTurn

		#  output thinking ... message - delay of a few seconds
		puts "Computer:  Processing next move ..."
		sleep 1.5
		
		computerMove = @computerAI.makeMove
		
		@theBoard.markerTakesSpot computerMove, "O"
		
		puts "Computer:  Took spot #{computerMove}"
		
	end

	
	private
	
	def playerWantsToQuit userSpot
	
		userSpot.strip!

		#  user entered in q or quit, case-insensitive
		userSpot =~ /^q$|^quit$/i
	end
	
end
