require_relative 'base'

class Command
    class CancelPlayerFromGameCommand < Command::Base
        def run
            if gamectl.in_list_or_waiting_list?(requester_username)
                player = gamectl.get_player_from_lists(requester_username)
                gamectl.cancel_player(player)

                pending_player = gamectl.get_last_player_in_list
                pending_message = pending_player ? "@#{pending_player&.get_username} a ton tour tu as 1 heure pour comfirmer ta présence\nécrit /comfirmer pour confirmer" : ""

                respond_multiple([
                    "#{requester_fullname} annulé ! 🟥\n",
                    pending_message
                ])
            else
                respond("#{requester_fullname} n'est pas dans la liste ! ❌")
                log_info(player.inspect)
            end
        end
    end
end