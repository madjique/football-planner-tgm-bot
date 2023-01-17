require_relative 'base'

class Command
    class BeginMatchCommand < Command::Base
        def run
            gamectl.startgame
            respond("Nouvelle liste réinitialisé ⚽")
            log_info_multiple([gamectl.inspect,gamectl.get_game.inspect])
        end
    end
end