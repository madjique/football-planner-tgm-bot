require 'require_all'

require_all 'commands/'

class CommandInvoker
    attr_reader :commands

    def initialize()
        @commands = {} 
    end

    # Singleton
    @instance = new
    private_class_method :new
    
    def self.instance
        @instance 
    end 


    # Commands

    def hello(ctx)
        if commands.key?("hello")
            commands["hello"].reload_context(ctx)
        else
            commands["hello"] = Command::HelloCommand.new(ctx)
        end
        commands["hello"].execute
    end

    def log(ctx)
        if commands.key?("log")
            commands["log"].reload_context(ctx)
        else
            commands["log"] = Command::AdminLogCommand.new(ctx)
        end
        commands["log"].execute_with_admin
    end

    def begin_match(ctx)
        if commands.key?("begin_match")
            commands["begin_match"].reload_context(ctx)
        else
            commands["begin_match"] = Command::BeginMatchCommand.new(ctx)
        end
        commands["begin_match"].execute_with_admin
    end

    def show_list(ctx)
        if commands.key?("show_list")
            commands["show_list"].reload_context(ctx)
        else
            commands["show_list"] = Command::ShowListCommand.new(ctx)
        end
        commands["show_list"].execute
    end

    def add_player_to_game(ctx)
        if commands.key?("add_player_to_game")
            commands["add_player_to_game"].reload_context(ctx)
        else
            commands["add_player_to_game"] = Command::AddPlayerToGameCommand.new(ctx)
        end
        commands["add_player_to_game"].execute_with_checks
    end

    def cancel_player_from_game(ctx)
        if commands.key?("cancel_player_from_game")
            commands["cancel_player_from_game"].reload_context(ctx)
        else
            commands["cancel_player_from_game"] = Command::CancelPlayerFromGameCommand.new(ctx)
        end
        commands["cancel_player_from_game"].execute_with_checks
    end

    def show_all_players(ctx)
        if commands.key?("show_all_players")
            commands["show_all_players"].reload_context(ctx)
        else
            commands["show_all_players"] = Command::ShowAllPlayersCommand.new(ctx)
        end
        commands["show_all_players"].execute_with_checks
    end

    def confirm_player_in_main_list(ctx)
        if commands.key?("confirm_player_in_main_list")
            commands["confirm_player_in_main_list"].reload_context(ctx)
        else
            commands["confirm_player_in_main_list"] = Command::ConfirmPlayerInMainListCommand.new(ctx)
        end
        commands["confirm_player_in_main_list"].execute_with_checks
    end

    def open_registrations(ctx)
        if commands.key?("open_registrations")
            commands["open_registrations"].reload_context(ctx)
        else
            commands["open_registrations"] = Command::OpenRegistrationsCommand.new(ctx)
        end
        commands["open_registrations"].execute_with_admin
    end

    def close_registrations(ctx)
        if commands.key?("close_registrations")
            commands["close_registrations"].reload_context(ctx)
        else
            commands["close_registrations"] = Command::CloseRegistrationsCommand.new(ctx)
        end
        commands["close_registrations"].execute_with_admin
    end
end