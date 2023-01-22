require_relative 'group_chat_base'

class Command
    class AddPlayerToGameCommand < Command::GroupChatBase
        def run
            if !gamectl.registrations_open
                respond("La liste n'a pas encore commencer !\nElle débute le Lundi a Midi (12:00 CET)")
                return 
            end
            if gamectl.in_list_or_waiting_list?(requester_username)
                log_info(gamectl.inspect)
                respond("#{requester_fullname} est déja dans la liste! ❌")

            elsif gamectl.pending_player?(requester_username) 
                gamectl.confirm_waiting_player(playerctl.existing_player(requester_username))
                respond("#{gamectl.get_last_player_in_list.fullname} rajouté a la liste des titulaires avec succes ✅ ⚽")
                
            else
                player = playerctl.get_player(requester_fullname,requester_username)
                gamectl.add_player(player)

                respond("#{player.fullname} rajouté a la liste avec succes ✅ ⚽")
                log_info(player.inspect)
            end
        end
    end
end