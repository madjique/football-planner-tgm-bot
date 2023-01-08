require_relative 'base'

class Command
    class CancelPlayerFromGameCommand < Command::Base
        def run
            player_fullname = "#{message.from.first_name} #{message.from.last_name}"
            if gamectl.in_list_or_waiting_list?(player_fullname)
                player = gamectl.get_player_by_fullname(player_fullname)
                gamectl.cancel_player(player)
                logger.info(gamectl.inspect)
                reply.text = "#{player_fullname} canceled sucessfully ! ✅"
            else
                reply.text = "#{player_fullname} in not in the game list! ❌"
                logger.info(player.inspect)
            end
        end
    end
end