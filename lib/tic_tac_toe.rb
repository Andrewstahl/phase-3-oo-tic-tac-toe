class TicTacToe
  attr_accessor :board
  attr_reader :turn_count

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  
  def initialize
    @board = [
      " ", 
      " ", 
      " ", 
      " ", 
      " ", 
      " ", 
      " ", 
      " ", 
      " "
    ]
    @turn_count = 0
  end

  def display_board
    puts self.board
  end

  def input_to_index(input)
    # Provides the index, which is 1 below whatever the user input is
    # since we're starting at 0
    input.to_i - 1
  end

  def move(index, token)
    self.board[index] = token
  end

  def position_taken?(index)
    self.board[index] != " "
  end
  
  def valid_move?(index)
    !position_taken?(index) && index <= 8 && index >= 0
  end

  def turn_count
    @turn_count
  end

  def current_player
    @turn_count % 2 == 0 ? "X" : "O"
  end

  def turn(position)
    index = input_to_index(position)
    if valid_move?(index)
      move(index, current_player)
    end
  end

  def won?
    
end