require_relative 'base'

class Command
    class AddPlayerToGameCommand < Command::Base
        def run
            new_player_fullname = "#{message.from.first_name} #{message.from.last_name}"
            if gamectl.in_list_or_waiting_list?(new_player_fullname)
                logger.info(gamectl.inspect)
                reply.text = "#{new_player_fullname} already in game list! ❌"
            else
                player = Player.new(new_player_fullname)
                gamectl.add_player(player)
                reply.text = "#{player.fullname} added to the game ✅ ⚽"
                logger.info(player.inspect)
            end
        end
    end
end