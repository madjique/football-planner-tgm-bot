require_relative '../model/Game'
require_relative '../model/Player'
require 'date'
require 'rufus-scheduler'

class GameController
    attr_reader :game, :pending_player, :registrations_open, :scheduler

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
        game.waiting_list.map { | player | "#{game.waiting_list.index(player)+1} - #{player.get_fullname}"} .join("\n")
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
                @pending_player << game.waiting_list.shift
                schedule_pending_timeout
            end
        end
    end

    def confirm_waiting_player
        if @pending_player
            game.players << @pending_player
            @pending_player = nil
        end 
    end

    def timeout_pending_player
        if @pending_player
            game.waiting_list << @pending_player
            @pending_player << game.waiting_list.shift
        end
    end

    def pending_player?(username)
        @pending_player&.get_username == username
    end

    def schedule_pending_timeout
        Thread.new do
            scheduler.in '1h' do
                timeout_pending_player
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
        scheduler.cron '0 12 * * 1' do
            open_registrations
            startgame
        end
        
        scheduler.cron '0 18 * * 5' do
            close_registrations
        end

        scheduler.join    
    end

    # Getters

    def get_pending_player
        @pending_player
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