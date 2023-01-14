require_relative 'base'

class Command
    class CloseRegistrationsCommand < Command::Base
        def run
            #TODO : Add dynamic admin liste
            if requester_username == "madjidboudis" 
                gamectl.close_registrations
                respond("La liste est fermé ! Bon match ❌")
            else
                respond("Vous n'avez pas les droits d'effectuer cette opération ❌")
            end
            log_info_multiple([gamectl.inspect,gamectl.get_game.inspect])
        end
    end
end