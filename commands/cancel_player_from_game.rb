require_relative 'base'

class Command
    class CancelPlayerFromGameCommand < Command::Base
        def run
            player_fullname = "#{message.from.first_name} #{message.from.last_name}"
            if gamectl.in_list_or_waiting_list?(player_fullname)
                player = gamectl.get_player_by_fullname(player_fullname)
                gamectl.cancel_player(player)

                log_info(gamectl.inspect)
                respond("#{player_fullname} canceled sucessfully ! ✅")
            else
                respond("#{player_fullname} in not in the game list! ❌")
                log_info(player.inspect)
            end
        end
    end
end