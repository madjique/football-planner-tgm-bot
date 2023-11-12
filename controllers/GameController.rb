require_relative '../model/Game'
require_relative '../model/Player'
require 'date'
require 'rufus-scheduler'

class GameController
    attr_reader :game, :registrations_open, :scheduler, :group_chat_id, :api

    def initialize(registrations_state=false)
        @game = Game.new()
        @registrations_open = registrations_state
        @scheduler = Rufus::Scheduler.new 
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

    def open_registrations
        @registrations_open = true
    end

    def close_registrations
        @registrations_open = false
    end

    def add_player(player)
        if game.players.size + game.pending_list.size < game.max_players
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
        game.waiting_list.map { | player | "#{game.waiting_list.index(player)+1} - #{player.get_fullname}"} .join("\n")
    end

    def get_pending_list
        game.pending_list.map { | player | "#{game.pending_list.index(player)+1} - #{player&.get_fullname}"} .join("\n")
    end

    def get_game_info
        {
            day: game.get_day,
            time: game.get_time,
            location: game.get_location 
        }
    end

    def cancel_player(player)
        return unless in_list_or_waiting_list?(player&.get_username)

        if game.waiting_list.include?(player)
            game.waiting_list.delete(player) #reject! {|elt| elt.to_s == player.to_s}
        else
            game.players.delete(player)
            if game.waiting_list.size > 0
                game.pending_list << game.waiting_list.shift
                schedule_pending_timeout(game.pending_list.last)
            end
        end
    end

    def confirm_waiting_player(player)
        if game.pending_list.include?(player)
            game.players << player
            game.pending_list.delete(player)
        end 
    end

    def timeout_pending_player(player)
        if game.pending_list.include?(player)
            game.waiting_list << player
            game.pending_list.delete(player)
        end

        next_pending_player
    end

    def next_pending_player
        player_from_waiting_list = game.waiting_list.shift

        game.pending_list << player_from_waiting_list if !player_from_waiting_list.nil?
        game.pending_list.last
    end

    def last_pending_player

        game.pending_list.last
    end

    def pending_player?(username)
        game.pending_list.include?(PlayerController.instance.existing_player(username))
    end

    def delete_pending_player(player)
        game.pending_list.delete(player)
    end

    def schedule_pending_timeout(player)
        Thread.new do
            scheduler.in '1h' do
                if pending_player?(player.get_username)
                    next_pending_player = timeout_pending_player(player)
                    send_message_in_group_chat("@#{next_pending_player&.get_username} a ton tour écrit /confirm pour te confirmer sur la liste 🌐\nTu as 1 heure pour confirmer ta présence sinon ça passe au prochain !")
                    schedule_pending_timeout(next_pending_player)
                end
            end
            scheduler.join  
        end
    end

    def update_registrations
        now = Time.now
        weekday =  DateTime.now.wday

        monday_after_12 = weekday >= 2 or (weekday == 1 and now.hour >= 12)  
        friday_before_18 = weekday <= 4 or (weekday == 5 and now.hour < 18) 

        if monday_after_12 and friday_before_18
            open_registrations
        else
            close_registrations
        end

    end

    def launch_automatic_registration_scheduler        
        scheduler.cron '0 11 * * 1' do
            open_registrations
            startgame
            send_message_in_group_chat("La liste est ouverte 🔓! faites /addme pour participer ⚽")
        end
        
        scheduler.cron '0 16 * * 5' do
            close_registrations
            send_message_in_group_chat("La liste est fermé 🔐! Bon Match ⚽")
        end

        scheduler.join    
    end

    def set_bot_ctx(_group_chat_id, _api)
        @group_chat_id = _group_chat_id
        @api = _api

        self
    end

    def send_message_in_group_chat(message)
        api.send_message(chat_id: group_chat_id, text: message)
    end

    # Getters

    def get_pending_player
        game.pending_list.last
    end

    def get_game
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

    def get_player_from_lists(username)
        get_lists.find { |player| player.to_s == username}
    end

    def get_last_player_in_list
        game.players.last
    end
    # Check functions

    def in_list_or_waiting_list?(username = '')
        get_lists.map { |player| player.to_s } .include?(username)
    end
end
