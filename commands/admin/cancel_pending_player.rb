require_relative 'admin_base'

class Command
    class CancelPendingPlayerCommand < Command::AdminBase
        def run
            pending_player = gamectl.get_pending_player
            return unless pending_player

            gamectl.reset_pending_player
            gamectl.next_pending_player
            
            next_pending_player = gamectl.get_pending_player
            gamectl.schedule_pending_timeout(next_pending_player)

            respond_multiple([
                "#{pending_player&.get_fullname} à été supprimé de la liste ✅\n",
                "@#{next_pending_player&.get_username} a ton tour écrit /confirm pour te confirmer sur la liste 🌐\n",
                "Tu as 1 heure pour confirmer ta présence sinon ça passe au prochain !"
            ])

            log_info_multiple([gamectl.inspect,gamectl.get_game.inspect])
        end
    end
end