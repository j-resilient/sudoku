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
            break
            #update tiles
        end
    end

    def get_input
        position = get_position
        value = get_value
        [position, value]
    end

    def get_position
        print "Please enter the position of the tile you want to change (i.e. row, column): "
        position = validate_position(gets.chomp)
        position
    end

    def validate_position(position)
        pos = position.delete(",").split("")
        if pos.length == 2 && acceptable_numbers?(pos)
            return format_position(pos)
        else
            get_position
        end
    end

    def acceptable_numbers?(pos)
        pos.all? { |num| num =~ /[[:digit:]]/ && num.to_i < 9 && num.to_i >= 0 }
    end

    def format_position(pos)
        pos.map { |num| num.to_i }
    end

    def get_value
        print "Please enter a value (i.e. a digit 1-9)"
        validate_value(gets.chomp.to_i)
    end

    def validate_value(value)
        return value if value > 0 && value <= 9
    end
end

if $PROGRAM_NAME == __FILE__
    game = Game.new
    game.play
end