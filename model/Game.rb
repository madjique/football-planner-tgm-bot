require_relative 'Player'

class Game
    attr_reader :location, :time, :max_players, :players, :waiting_list, :pending_list, :day

    def initialize(max_players = 18, location = "Pte de Clignacourt", time ='18H30', day = 'Vendredi')
      @max_players = max_players
      @location = location
      @time = time
      @day = day
      @players = []
      @pending_list = []
      @waiting_list = []
    end

    def reset(max_players = 18, location = "Pte de Clignacourt", time ='18H30', day = 'Vendredi')
        @max_players = max_players
        @location = location
        @time = time
        @day = day
        @players = []
        @pending_list = []
        @waiting_list = []
    end

    # Getters
    
    def get_day
      day
    end
    
    def get_time
      time
    end

    def get_location 
      location
    end
end
 