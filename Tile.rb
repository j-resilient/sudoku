require 'colorize'
class Tile
    attr_reader :given, :value
    attr_writer :value

    def initialize(value, given)
        @value = value
        @given = given
    end

    def to_s
        return @value.colorize(:red) if !@given
        @value
    end

end