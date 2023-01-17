require_relative 'base'

class Command
    class MoveFromWaitingListToPendingCommand < Command::Base
        def run
            prev_pending_player = gamectl.get_pending_player
            return unless prev_pending_player
            gamectl.timeout_pending_player
            next_pending_player = gamectl.get_pending_player
            return unless next_pending_player
            gamectl.schedule_pending_timeout

            respond_multiple([
                "#{prev_pending_player&.get_fullname} trop tard pour confirmer ça passe au prochain !❌\n",
                "@#{next_pending_player&.get_username} a ton tour écrit /confirm pour te confirmer sur la liste 🌐\n",
                "Tu as 1 heure pour confirmer ta présence sinon ça passe au prochain !"
            ])
            
            log_info(gamectl.get_game)
        end
    end
end