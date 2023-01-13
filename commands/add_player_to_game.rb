require_relative 'base'

class Command
    class AddPlayerToGameCommand < Command::Base
        def run
            new_player_fullname = "#{message.from.first_name} #{message.from.last_name}"
            new_player_username = message.from.username
            if gamectl.in_list_or_waiting_list?(new_player_username)
                log_info(gamectl.inspect)
                respond("#{new_player_fullname} est déja dans la liste! ❌")
            else
                player = Player.new(new_player_fullname,new_player_username)
                gamectl.add_player(player)

                respond("#{player.fullname} rajouté a la liste avec succes ✅ ⚽")
                log_info(player.inspect)
            end
        end
    end
end