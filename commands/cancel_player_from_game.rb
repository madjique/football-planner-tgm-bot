require_relative 'base'

class Command
    class CancelPlayerFromGameCommand < Command::Base
        def run
            player_fullname = "#{message.from.first_name} #{message.from.last_name}"
            player_username = message.from.username
            if gamectl.in_list_or_waiting_list?(player_username)
                player = gamectl.get_player_from_lists(player_username)
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