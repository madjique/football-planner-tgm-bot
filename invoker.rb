require 'require_all'

require_all 'commands/admin/'
require_all 'commands/group_chat/'
require_all 'commands/public/'

class CommandInvoker
    attr_reader :commands, :ctx

    def initialize()
        @commands = {} 
        @ctx = {}
    end

    # Singleton
    @instance = new
    private_class_method :new
    
    def self.instance
        @instance 
    end 

    def load_context(_ctx)
        @ctx = _ctx
    end

    # Commands

    def hello
        if commands.key?("hello")
            commands["hello"].reload_context(ctx)
        else
            commands["hello"] = Command::HelloCommand.new(ctx)
        end
        commands["hello"].execute
    end

    def log
        if commands.key?("log")
            commands["log"].reload_context(ctx)
        else
            commands["log"] = Command::LogCommand.new(ctx)
        end
        commands["log"].execute
    end

    def begin_match
        if commands.key?("begin_match")
            commands["begin_match"].reload_context(ctx)
        else
            commands["begin_match"] = Command::BeginMatchCommand.new(ctx)
        end
        commands["begin_match"].execute
    end

    def show_list
        if commands.key?("show_list")
            commands["show_list"].reload_context(ctx)
        else
            commands["show_list"] = Command::ShowListCommand.new(ctx)
        end
        commands["show_list"].execute
    end

    def add_player_to_game
        if commands.key?("add_player_to_game")
            commands["add_player_to_game"].reload_context(ctx)
        else
            commands["add_player_to_game"] = Command::AddPlayerToGameCommand.new(ctx)
        end
        commands["add_player_to_game"].execute
    end

    def cancel_player_from_game
        if commands.key?("cancel_player_from_game")
            commands["cancel_player_from_game"].reload_context(ctx)
        else
            commands["cancel_player_from_game"] = Command::CancelPlayerFromGameCommand.new(ctx)
        end
        commands["cancel_player_from_game"].execute
    end

    def show_all_players
        if commands.key?("show_all_players")
            commands["show_all_players"].reload_context(ctx)
        else
            commands["show_all_players"] = Command::ShowAllPlayersCommand.new(ctx)
        end
        commands["show_all_players"].execute
    end

    def confirm_player_to_main_list
        if commands.key?("confirm_player_to_main_list")
            commands["confirm_player_to_main_list"].reload_context(ctx)
        else
            commands["confirm_player_to_main_list"] = Command::ConfirmPlayerToMainListCommand.new(ctx)
        end
        commands["confirm_player_to_main_list"].execute
    end

    def open_registrations
        if commands.key?("open_registrations")
            commands["open_registrations"].reload_context(ctx)
        else
            commands["open_registrations"] = Command::OpenRegistrationsCommand.new(ctx)
        end
        commands["open_registrations"].execute
    end

    def close_registrations
        if commands.key?("close_registrations")
            commands["close_registrations"].reload_context(ctx)
        else
            commands["close_registrations"] = Command::CloseRegistrationsCommand.new(ctx)
        end
        commands["close_registrations"].execute
    end

    def move_from_waiting_list_to_pending
        if commands.key?("move_from_waiting_list_to_pending")
            commands["move_from_waiting_list_to_pending"].reload_context(ctx)
        else
            commands["move_from_waiting_list_to_pending"] = Command::MoveFromWaitingListToPendingCommand.new(ctx)
        end
        commands["move_from_waiting_list_to_pending"].execute
    end

    def load_group_players
        if commands.key?("load_group_players")
            commands["load_group_players"].reload_context(ctx)
        else
            commands["load_group_players"] = Command::LoadGroupPlayersCommand.new(ctx)
        end
        commands["load_group_players"].execute
    end

    def cancel_pending_player
        if commands.key?("cancel_pending_player")
            commands["cancel_pending_player"].reload_context(ctx)
        else
            commands["cancel_pending_player"] = Command::CancelPendingPlayerCommand.new(ctx)
        end
        commands["cancel_pending_player"].execute
    end
end