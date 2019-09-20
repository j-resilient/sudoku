require 'colorize'
class Tile
    attr_reader :given, :value
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