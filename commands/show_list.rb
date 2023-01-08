require_relative 'base'

class Command
    class ShowListCommand < Command::Base
        def run
            logger.info(gamectl.get_main_list)

            reply.text = "\n Liste des titulaires ***** \n"
            reply.text += gamectl.get_main_list
            reply.text += "\n Liste d'attente **********\n"
            reply.text += gamectl.get_waiting_list
        end
    end
end