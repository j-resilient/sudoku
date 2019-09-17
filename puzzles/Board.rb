class Board
    def initialize
        # @grid = grid
    end

    def from_file
        rows = File.readlines("puzzles/sudoku1_almost.txt")
        rows.each { |row| puts row}
    end
end

if $PROGRAM_NAME == __FILE__
    board = Board.new
    board.from_file
end