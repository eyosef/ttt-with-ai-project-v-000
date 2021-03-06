require 'pry'

class Game

	attr_accessor :player_1, :player_2, :board

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # bottom row
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [2,4,6],
    [0,4,8]

  ]

  def initialize (player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
  	@player_1 = player_1
  	@player_2 = player_2
  	@board = board
  end

  def board=(board)
    @board = board
  end

  def current_player
  	board.turn_count.odd? ? player_2 : player_1
  end

  def over?
  	draw? || won?
  end

  def draw?
  	board.full? && !won?
  end

  # def won?
  #   WIN_COMBINATIONS.detect do |combo|
  #     @board.cells[combo[0]] == @board.cells[combo[1]] && @board.cells[combo[1]] == @board.cells[combo[2]] && @board.cells[combo[0]] != " "
  #   end
  # end

  def won?
    WIN_COMBINATIONS.detect do |win_combination|
      @board.cells[win_combination[0]] == @board.cells[win_combination[1]] && @board.cells[win_combination[0]] == @board.cells[win_combination[2]] && @board.cells[win_combination[1]] != " "
    end
  end

  def winner
  	board.cells[won?.first] if won?
  end

  def turn
 	puts "Enter your move player #{current_player.token}"
 	move = current_player.move(board)
   	if board.valid_move?(move)
   		board.update(move, current_player)
   	else
   		puts "invalid input, please try again"
   		turn
   	end
  end

  def play
  	until over?
  		turn
  	end
  	if won?
  		puts "Congratulations #{winner}!"
  	elsif draw?
  		puts "Cat's Game!"
  	end
  end

end 