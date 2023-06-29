class Roll
    attr_reader :pins, :attempt
    VALID_INPUT_REGEX = /(^[0-9]$)|(F)|(^[1][0]$)/

    def initialize(attempt)
        raise ArgumentError, "Invalid input: #{attempt}" unless validate_input(attempt)
        @attempt = attempt.freeze
        @pins = parse_pins(@attempt).freeze
    end

    private 

    def parse_pins(attempt)
        case attempt
        when "F"
            0
        else
            attempt.to_i
        end
    end

    def validate_input(attempt)
        attempt =~ VALID_INPUT_REGEX
    end
end
