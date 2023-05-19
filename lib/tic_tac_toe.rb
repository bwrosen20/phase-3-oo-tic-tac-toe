require "pry"

class TicTacToe


    WIN_COMBINATIONS=[
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize
        @board=[" "," "," "," "," "," "," "," "," "]
    end

    def display_board
        puts" #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts"-----------"
        puts" #{@board[3]} | #{@board[4]} | #{@board[5]} " 
        puts"-----------"
        puts" #{@board[6]} | #{@board[7]} | #{@board[8]} " 
    end

    def input_to_index(input)
       return input.to_i-1
        
    end

    def move(index,token)
        @board[index]="#{token}"
    end

    def position_taken?(position)
        @board[position] != " "
    end

    def valid_move?(position)
        !position_taken?(position) && position.between?(0,8)
    end

    def turn_count
        i=0
        @board.each do |slot|
            if slot ==" "
                nil
            else
                i+=1
            end
        end
        i
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts"Enter the square for your move (1-9):"
        index=input_to_index(gets.chomp)

        if valid_move?(index)
            move(index,current_player)
            display_board
        else
            turn
        end

    end

    def won?
        winner=false
        possible_winner=current_player == "X" ? "O" : "X" 
        winner_array=[]
        @board.map.with_index do |letter, index|
            letter == possible_winner ? winner_array << index : nil
        end

        WIN_COMBINATIONS.each do |combo|
            i=0
            combo.each do |number|
                winner_array.include?(number) ? i+=1 : i
            end
            i==3 ? winner=combo : nil
        end
        winner
        
    end

    def full?
        answer=true
        @board.each do |slot|
            slot==" " ? answer=false : nil
        end
        answer
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        !draw? ? winner=current_player == "X" ? "O" : "X" :winner=nil
        over? ? winner : nil
    end

    def play
        turn until over?

        winner ? puts("Congratulations #{winner}!") : puts("Cat's Game!")

    end
end

# binding.pry