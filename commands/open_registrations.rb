require_relative 'base'

class Command
    class OpenRegistrationsCommand < Command::Base
        def run
            #TODO : Add dynamic admin liste
            if requester_username == "madjidboudis" 
                gamectl.open_registrations
                respond("Nouvelle liste ! inscription ouvertes ⚽")
            else
                respond("Vous n'avez pas les droits d'effectuer cette opération ❌")
            end
            log_info_multiple([gamectl.inspect,gamectl.get_game.inspect])
        end
    end
end