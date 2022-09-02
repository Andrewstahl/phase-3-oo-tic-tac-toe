require 'pry'

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
    puts " " + self.board[0..2].join(" | ") + " "
    puts "-----------"
    puts " " + self.board[3..5].join(" | ") + " "
    puts "-----------"
    puts " " + self.board[6..8].join(" | ") + " "
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
    @turn_count = @board.count { |item| item != " " }
  end

  def current_player
    # First, we have to reset the current_player variable
    turn_count
    # X goes first, followed by O
    # O should go on the even numbers
    (@turn_count == 0 || self.turn_count.even?) ? "X" : "O"
  end

  # This is a prompt that allows us to use gets
  def prompt(*args)
    print(*args)
    gets.chomp
  end

  def turn
    # When you convert anything to an integer, if it's not a
    # number it will show up as 0
    position = (prompt "Enter in a position from 1 - 9: ")
    
    if position.to_i.between?(1, 9)
      index = input_to_index(position.to_i)
      if valid_move?(index)
        move(index, current_player)
      else
        puts "Invalid"
        self.turn
      end
    else
      begin
        raise InputError
      rescue InputError => error
        puts error.message
      end
      self.turn
    end
  end

  def won?
    won = nil
    WIN_COMBINATIONS.each do |combination|
      pos1, pos2, pos3 = combination
      # If each of these positions have the same value,
      # that means we have a winning combination
      if [
        self.board[pos1], 
        self.board[pos2], 
        self.board[pos3]
      ].uniq.length == 1 then
        # Returns the array of winning combinations
        won = [
          self.board[pos1], 
          self.board[pos2], 
          self.board[pos3]
        ]
      end
    end
    binding.pry
    won
  end

  def full?
    @board.count { |item| item != " " } == 9
  end

  def draw?
    self.full? && !self.won?
  end

  def over?
    self.full? || !self.won?
  end

  def winner
    # If the game is won, I want to return the first element
    # of the winning array, which will tell me the player
    # that won
    
    # decision = self.won?
    # if decision != nil
    #   decision[0]
    # end
    
    # Let's simplify this since the logic will be built into the "Play" method
    self.won?[0]
  end

  def play
    if !self.over?
      self.turn
      self.play
    else
      if self.won? != nil
        puts "Congratulations, #{self.won?}"
      else
        puts "This has ended in a draw"
      end
    end
  end
  
  class InputError < StandardError
    def message
      "You must enter in a number between 1 and 9"
    end
  end
  
  binding.pry
end

game = TicTacToe.new
game.board = ["O", " ", " ", " ", "X", " ", " ", " ", "X"]
   
