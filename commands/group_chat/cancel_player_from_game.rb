require_relative 'group_chat_base'

class Command
    class CancelPlayerFromGameCommand < Command::GroupChatBase
        def run
            if playerctl.existing_player(requester_username)

                if gamectl.in_list_or_waiting_list?(requester_username)
                    player = gamectl.get_player_from_lists(requester_username)
                    gamectl.cancel_player(player)

                    pending_player = gamectl.last_pending_player
                elsif gamectl.pending_player?(requester_username)
                    gamectl.delete_pending_player(playerctl.existing_player(requester_username))

                    pending_player = gamectl.next_pending_player
                end

                pending_message = pending_player ? "@#{pending_player&.get_username} a ton tour tu as 1 heure pour comfirmer ta présence\nécrit /confirm pour confirmer" : " "

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