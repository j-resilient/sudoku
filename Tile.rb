require 'colorize'
class Tile
    attr_reader :given
    attr_writer :value

    def initialize(value)
        @value = value
        @given = @value == "0"
    end

    def to_s
        return @value.colorize(:red) if !@given
        @value
    end

end