require_relative '../model/Game'
require_relative '../model/Player'

class GameController
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

    def get_main_list
        game.players.map { | player | "#{game.players.index(player)+1} - #{player.get_fullname}"} .join("\n")
    end

    def get_waiting_list
        game.waiting_list.map { | player | player.to_s} .join("\n")
    end

    def get_game_info
        {
            day: game.get_day,
            time: game.get_time,
            location: game.get_location 
        }
    end

    def cancel_player(player)
        if game.waiting_list.include?(player)
            game.waiting_list.delete(player) #reject! {|elt| elt.to_s == player.to_s}
        else
            game.players.delete(player)
            if game.waiting_list.size > 0
                transfered_player << game.waiting_list.shift
                game.players << transfered_player

                waiting_player_confirmation(transfered_player)
            end
        end
    end

    def waiting_player_confirmation(player)
        nil
    end

    # Getters

    def get_game()
        game
    end
    
    def get_players
        game.players
    end

    def get_waiting_list_players
        game.waiting_list
    end

    def get_lists
        game.players + game.waiting_list
    end

    def get_player_by_fullname(fullname)
        get_lists.find { |player| player.to_s == fullname}
    end

    # Check functions

    def in_list_or_waiting_list?(username = '')
        get_lists.map { |player| player.to_s } .include?(username)
    end
end