require_relative 'admin_base'

class Command
    class LogCommand < Command::AdminBase
        def run
            respond("logs displayed in console ✅")
            logger.info(gamectl.inspect)
            logger.info(gamectl.get_game.inspect)
            logger.info(message.inspect)
        end
    end
end