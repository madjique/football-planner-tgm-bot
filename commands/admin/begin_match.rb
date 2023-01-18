require_relative 'admin_base'

class Command
    class BeginMatchCommand < Command::AdminBase
        def run
            gamectl.startgame
            respond("Nouvelle liste réinitialisé ⚽")
            log_info_multiple([gamectl.inspect,gamectl.get_game.inspect])
        end
    end
end