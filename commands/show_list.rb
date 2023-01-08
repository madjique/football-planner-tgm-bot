require_relative 'base'

class Command
    class ShowListCommand < Command::Base
        def run
            log_info(gamectl.get_main_list)

            respond_multiple([
                "\n Liste des titulaires ***** \n",
                gamectl.get_main_list,
                "\n Liste d'attente **********\n",
                gamectl.get_waiting_list
            ])
        end
    end
end