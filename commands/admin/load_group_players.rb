require_relative 'admin_base'

class Command
    class LoadGroupPlayersCommand < Command::AdminBase
        def run

            logs = File.read("log.txt")
            
            prev_list_players = logs.scan(/@players=\[[^\]]+\].*\]>/)&.last
            
            regex = /@fullname="(?<fullname>[^"]*)\s*"[^@]*@username="(?<username>[^"]*)"/

            main_list = prev_list_players&.scan(regex)

            main_list&.each do |player_infos|
                player = playerctl.get_player(player_infos[0],player_infos[1])
                gamectl.add_player(player)
            end

            respond("Group players loaded successfully! 🔋 and list adjusted ")
        end
    end
end