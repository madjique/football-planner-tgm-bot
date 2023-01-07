require_relative 'Player'

class Game

    @instance = new()
    private_class_method :new

    def self.instance
        @instance
    end

    attr_reader :location, :time, :max_players, :players, :waiting_list

    def initialize(max_players = 18, location = 'Pte de Clignacourt', time ='18H30')
      @max_players = max_players
      @location = location
      @time = time
      @players = []
      @waiting_list = []
    end

    def reset
        @max_players = max_players
        @players = []
        @waiting_list = []
    end
end
 