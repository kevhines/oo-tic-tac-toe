require 'pry'

class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2], # top row
        [3,4,5], # middle row
        [6,7,8], # bottom row
        [0,3,6], # first column
        [1,4,7], # second column
        [2,5,8], # third column
        [0,4,8], # down right diagonal
        [2,4,6]  # down left diagonal
    ]

    attr_reader :board

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        line = "-----------"
        row = ""
        counter = 1
        self.board.each do |square|
            row << " #{square} "        
            if counter.remainder(3) == 0
                puts row
                puts line
                row = ""
            else
                row << "|"
            end
            counter +=1
        end    
    end

    def input_to_index(input)
        input.to_i - 1        
    end

    def move(index,token = "X")
        self.board[index] = token
    end

    def position_taken?(index)
        self.board[index] == " " ? false : true 
    end

    def valid_move?(index)
        index.between?(0,8) && !self.position_taken?(index) ?  true : false
    end

    def turn_count
        self.board.select{|square| square != " " }.size
    end

    def current_player
        self.turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Select a square (1 -> 9)"
        #puts "#{self.current_player}'s move:"
        index_move = self.input_to_index(gets.chomp)
        if self.valid_move?(index_move)
            self.move(index_move,self.current_player)
        else
            puts "\ninvalid move \n\n"
            self.turn
        end
        self.display_board
    end

    # def players_board(player = "X")
    #     self.board.map.with_index {|square, i| i if square == player }.compact
    # end

    # def won? 
    #     winning_combo = WIN_COMBINATIONS.detect do |combo|
    #      #   binding.pry
    #         (combo - self.players_board("X")).empty? || (combo - self.players_board("O")).empty?
    #     end
    #     #binding.pry
    #     winning_combo == nil ? false : winning_combo
    # end

    def won? 
        winning_combo = WIN_COMBINATIONS.detect do |combo|
          #  binding.pry
            self.board[combo[0]] == self.board[combo[1]] && self.board[combo[0]] == self.board[combo[2]] && self.position_taken?(combo[0])
        end
        #binding.pry
        winning_combo == nil ? false : winning_combo
    end

        
    def full?
        self.turn_count == 9 ? true : false
    end

    def draw?
        self.full? && self.won? == false ? true : false
    end

    def over?
        self.draw? ||  self.won? != false ? true : false
    end

    def winner
       # binding.pry
        self.board[self.won?[0]] if self.won? != false
    end

    def play
        self.display_board
        until self.over? do
            self.turn
        end
       
        if self.won?
            puts "Congratulations #{self.winner}!"
        else
            puts "Cat's Game!"
        end
    
    end

end

