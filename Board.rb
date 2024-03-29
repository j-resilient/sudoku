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
            grid << row.chomp.split("").map do |char| 
                if char.to_i != 0
                    Tile.new(char, false)
                else
                    Tile.new(char, true)
                end
            end
        end
        grid
    end

    def render
        system("clear")
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
        return false if !self.columns_complete?
        return false if !self.squares_complete?
        true
    end

    def remaining_zeroes?
        @grid.any? do |row| 
            row.any? { |num| num.to_s == '0'}
        end
    end

    def rows_complete?
        @grid.all? { |row| includes_all_digits?(row) }
    end

    def columns_complete?
        (0...9).all? do |col_idx|
            col = []
            @grid.each { |row| col << row[col_idx] }
            includes_all_digits?(col)
        end
    end

    def squares_complete?
        squares = Array.new(9) { [] }
        flat_grid = @grid.flatten
        arr_idx = 0

        while !flat_grid.empty? 
            squares[arr_idx] += flat_grid.shift(3)

            if squares[arr_idx].length == 9
                return false if !includes_all_digits?(squares[arr_idx])
                squares.delete_at(arr_idx)
            else
                arr_idx == 2 ? arr_idx = 0 : arr_idx += 1
            end
        end
        
        true
    end

    def includes_all_digits?(tiles)
        numbers = get_array_of_values(tiles)
        (1..9).all? { |num| numbers.include?(num.to_s) }
    end

    def update_tile(position, value)
        @grid[position[0]][position[1]] = Tile.new(value, true)
    end

end