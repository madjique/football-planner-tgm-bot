require_relative '../model/Game'
require_relative '../model/Player'

class PlayerController
    attr_reader :game

    def initialize()
        @game = Game.new()
    end

    # Singleton
    @instance = new
    private_class_method :new
    
    def self.instance
        @instance 
    end

    # functions

    def get_player(fullname,username)
        player = existing_player(username)
        return player if player
        return Player.new(fullname,username)
    end

    def existing_player(username)
        Player.all.find { |player| player.to_s == username }
    end

end