class Board
    def initialize
        @grid = self.from_file
    end

    def from_file
        grid = []
        rows = File.readlines("puzzles/sudoku1_almost.txt")
        rows.each do |row|
            grid << row.chomp.split("")
        end
        grid
    end

    def render
        @grid.each_with_index do |row, row_idx|
            row.each_with_index do |col, col_idx|
                print col + " "
                print "  " if (col_idx + 1) % 3 == 0
            end
            puts
            puts if (row_idx + 1) % 3 == 0
        end
    end
end

if $PROGRAM_NAME == __FILE__
    board = Board.new
    board.from_file
    board.render
end