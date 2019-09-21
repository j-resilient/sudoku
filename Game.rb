require_relative 'Board.rb'

require 'byebug'

class Game
    def initialize
        @board = Board.new
    end

    def play
        until @board.solved?
            # debugger
            @board.render
            position, value = get_input
            @board.update_tile(position, value)
        end
        @board.render
        puts "You win!"
    end

    def get_input
        [get_position, get_value]
    end

    def get_position
        print "Please enter the position of the tile you want to change (i.e. row, column): "
        position = validate_position(gets.chomp)
        position
    end

    def validate_position(position)
        get_position if position.length != 3 || !position.include?(",")
        pos = format_position(position)
        pos = check_digits(pos)
        return pos if tile_given?(pos)
        get_position
    end

    def format_position(position)
        position.delete(",").split("")
    end

    def check_digits(pos)
        pos.map do |num| 
            if num =~ /[[:digit:]]/ && acceptable_number?(num)
                num.to_i
            else
                get_position
            end
        end
    end

    def acceptable_number?(pos)
        # pos.all? { |num| num =~ /[[:digit:]]/ && num.to_i < 9 && num.to_i >= 0 }
        pos.to_i < 9 && pos.to_i >= 0
    end

    def tile_given?(pos)
        @board[pos].given
    end

    def get_value
        print "Please enter a value (i.e. a digit 1-9): "
        validate_value(gets.chomp)
    end

    def validate_value(value)
        value.to_i if value =~ /[[:digit:]]/
        return value if value.to_i > 0 && value.to_i <= 9
        get_value
    end
end

if $PROGRAM_NAME == __FILE__
    game = Game.new
    game.play
end