# ruby-TicTacToe
a ruby implementation of TicTacToe

This is a command-line Tic-Tac-Toe game that I worked on back in 2011 when I was learning ruby for the first.  

The player is presented with the option to go first or not, and the computer plays against the player.  

Implementing the AI logic was fun to work on.  I found that I had to focus on the end of the game before focusing on the beginning.  Here's what I mean:

1.  Can I win the game with a single move?
2.  Do I need to block in order to prevent my opponent from winning?
3.  Take the center square (if it's available)
4.  Search all the possible ways to win the game.  For the first "wayToWin" that isn't hindered by an opponent's marker, take a corner spot within that "wayToWin", otherwise take the middle spot of that "wayToWin"
5.  If execution reaches here, then there's no way to win the game ... simply take an available spot


