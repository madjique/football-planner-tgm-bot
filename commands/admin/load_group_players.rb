require_relative 'admin_base'

class Command
    class LoadGroupPlayersCommand < Command::AdminBase
        def run

            main_list = []

            main_list.each do |player_infos|
                player = playerctl.get_player(player_infos[:fullname],player_infos[:username])
                gamectl.add_player(player)
            end

            respond("Group players loaded successfully! 🔋 and list adjusted ")
        end
    end
end