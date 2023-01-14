require_relative 'base'

class Command
    class BeginMatchCommand < Command::Base
        def run
            #TODO : Add dynamic admin liste
            if requester_username == "madjidboudis" 
                gamectl.startgame
                respond("Nouvelle liste réinitialisé ⚽")
            else
                respond("Vous n'avez pas les droits pour relancer la liste ❌")
            end
            log_info_multiple([gamectl.inspect,gamectl.get_game.inspect])
        end
    end
end