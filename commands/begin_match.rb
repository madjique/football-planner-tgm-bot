require_relative 'base'

class Command
    class BeginMatchCommand < Command::Base
        def run
            gamectl.startgame
            logger.info(gamectl.inspect)
            logger.info(gamectl.get_game.inspect)
            reply.text = "Game initilialized ⚽"
        end
    end
end