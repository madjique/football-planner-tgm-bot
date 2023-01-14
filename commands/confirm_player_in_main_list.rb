require_relative 'base'

class Command
    class ConfirmPlayerInMainListCommand < Command::Base
        def run
            requester_fullname = "#{message.from.first_name} #{message.from.last_name}"
            requester_username = message.from.username
            if gamectl.pending_player?(requester_username)
                gamectl.confirm_waiting_player
                respond("#{gamectl.get_last_player_in_list.fullname} rajouté a la liste avec succes ✅ ⚽")
            else
                respond("#{requester_fullname}, Vous n'etes pas en attente de confirmation ! ❌")
            end
        end
    end
end