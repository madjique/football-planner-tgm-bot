require_relative 'admin_base'

class Command
    class CloseRegistrationsCommand < Command::AdminBase
        def run
            gamectl.close_registrations
            respond("La liste est fermé ! Bon match ❌")
            log_info_multiple([gamectl.inspect,gamectl.get_game.inspect])
        end
    end
end