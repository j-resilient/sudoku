# if factory methods involve creating a little class to create the grid,
# move [] and []= so that I can use them in update_tile

require_relative "Tile.rb"
require 'byebug'

class Board
    def [](position)
        @grid[position[0]][position[1]]
    end

    def []=(position, el)
        @grid[position] = el
    end

    def get_array_of_values(tiles)
        tiles.map { |tile| tile.value }
    end
    
    def initialize
        @grid = self.from_file
    end

    def from_file
        grid = []
        rows = File.readlines("puzzles/sudoku1_almost.txt")
        rows.each do |row|
            grid << row.chomp.split("").map { |char| Tile.new(char) }
        end
        grid
    end

    def render
        puts
        @grid.each_with_index do |row, row_idx|
            row.each_with_index do |col, col_idx|
                print "#{col} "
                print "  " if (col_idx + 1) % 3 == 0
            end
            puts
            puts if (row_idx + 1) % 3 == 0
        end
    end

    def solved?
        return false if self.remaining_zeroes? == true
        return false if !self.rows_complete?
        true
    end

    # check if any numbers have not been changed
    def remaining_zeroes?
        @grid.any? do |row| 
            row.any? { |num| num.to_s == '0'}
        end
    end

    def rows_complete?
        @grid.all? { |row| check_row(get_array_of_values(row)) }
    end

    def check_row(row)
        (1..9).all? { |num| row.include?(num.to_s) }
    end

    # rows contain 0-9
    # columns contain 0-9
    # squares contain 0-9

    def update_tile(position, el)
        @grid[position[0]][position[1]] = el
    end

end

if $PROGRAM_NAME == __FILE__
    board = Board.new
    board.from_file
    board.render
    puts board.solved?
end