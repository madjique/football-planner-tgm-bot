require_relative 'base'

class Command
    class CloseRegistrationsCommand < Command::Base
        def run
            gamectl.close_registrations
            respond("La liste est fermé ! Bon match ❌")
            log_info_multiple([gamectl.inspect,gamectl.get_game.inspect])
        end
    end
end