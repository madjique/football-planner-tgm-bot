require_relative 'admin_base'

class Command
    class ShowAllPlayersCommand < Command::AdminBase
        def run
            log_info(Player.all)
            respond_multiple([
                "\n*************************\nListe de tous les joueurs dans ce groupe \n---\n",
                Player.all.map { | player | "#{Player.all.find_index(player)+1} - #{player.get_fullname}"} .join("\n")
            ])
        end
    end
end