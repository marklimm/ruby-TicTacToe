# ruby-TicTacToe
a command-line based ruby game with AI programming logic included 

This is a command-line Tic-Tac-Toe game that I worked on back in 2011 while learning ruby for the first time.  

The player is presented with the option to go first or not, and the computer plays against the player.  The Tic-Tac-Toe board is drawn to the command line after each turn

The most fun thing to work on was the computer's strategy for approaching the game.  It involves identifying the current state of the board and making the most advantageous move available.  The AI logic is summarized as:

1.  Can I win the game with a single move?
2.  Do I need to block in order to prevent my opponent from winning?
3.  Take the center square (if it's available)
4.  Search all the possible ways to win the game.  For the first "wayToWin" that isn't hindered by an opponent's marker, take a corner spot within that "wayToWin", otherwise take the middle spot of that "wayToWin"
5.  If execution reaches here, then there's no way to win the game ... simply take an available spot


