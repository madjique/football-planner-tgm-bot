require_relative 'base'

class Command
    class BeginMatchCommand < Command::Base
        def run
            gamectl.startgame
            
            log_info_multiple([gamectl.inspect,gamectl.get_game.inspect])
            respond("new Game initilialized ⚽")
        end
    end
end