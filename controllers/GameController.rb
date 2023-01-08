require_relative '../model/Game'
require_relative '../model/Player'

class GameController
    attr_reader :game
  
    def initialize()
        @game = Game.instance
    end
    
    # Commands

    def startgame
        game.reset
    end

    def add_player(player)
        if game.players.size < game.max_players
            game.players << player
        else
            game.waiting_list << player
        end
    end

    def remove_player(player)
        game.players.delete(player)
    end

    def move_player_from_waiting_list
        if game.waiting_list.any?
            game.player = game.waiting_list.shift
            game.players << player
        end
    end

    # Getters

    def get_game()
        game
    end
    
    def get_players
        game.players
    end

    def get_list
        game.players.map { | player | player.to_s} .join("\n")
    end

    def get_waiting_list_players
        game.waiting_list
    end
end