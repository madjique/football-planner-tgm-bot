require_relative 'public_base'

class Command
    class ShowListCommand < Command::PublicBase
        def run
            game_infos = gamectl.get_game_info

            pending_list = !gamectl.get_pending_list.empty? ? "\n*************************\nEn attente de confirmation\n---\n#{gamectl.get_pending_list}" : ""
            respond_multiple([
                "#{game_infos[:day]}","\nHeure : #{game_infos[:time]}","\nà #{game_infos[:location]}",
                "\n*************************\nListe des titulaires\n---\n",
                gamectl.get_main_list,
                pending_list,
                "\n*************************\nListe d'attente\n---\n",
                gamectl.get_waiting_list
            ])

            log_info(gamectl.get_game)
        end
    end
end