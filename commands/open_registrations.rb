require_relative 'base'

class Command
    class OpenRegistrationsCommand < Command::Base
        def run
            gamectl.open_registrations
            respond("Nouvelle liste ! inscription ouvertes ⚽")
            log_info_multiple([gamectl.inspect,gamectl.get_game.inspect])
        end
    end
end