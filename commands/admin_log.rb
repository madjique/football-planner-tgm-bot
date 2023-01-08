require_relative 'base'

class Command
    class AdminLogCommand < Command::Base
        def run
            respond("logs displayed in console ✅")
            logger.info(gamectl.inspect)
            logger.info(gamectl.get_game.inspect)
            logger.info(message.inspect)
        end
    end
end