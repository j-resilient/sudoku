class Tile
    def initialize(value)
        @value = value
        @given = value == 0 ? false : true
    end

    def to_s
        @value
    end

end