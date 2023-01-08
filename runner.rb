require 'telegram_bot'
require "logger"
require_relative 'controllers/GameController'


logger = Logger.new(STDOUT)

token = ENV['FMP_BOT_TOKEN'] 
bot = TelegramBot.new(token: token)
gamectl = GameController.new

# Default inits

gamectl.startgame

# Main Loop

bot.get_updates(fail_silently: true) do |message|
    puts "@#{message.from.username}: #{message.text}"
    command = message.get_command_for(bot)

    message.reply do |reply|
        replying = true

        begin
            case command
            when /start/i
                reply.text = "This is a starting"
            when /hello/i
                reply.text = "Hello ⚽"
            when /admin/i
                reply.text = "admin"
                logger.info(gamectl.inspect)
                logger.info(gamectl.get_game.inspect)
                logger.info(message.inspect)
            when /beginmatch/i
                gamectl.startgame
                logger.info(gamectl.inspect)
                logger.info(gamectl.get_game.inspect)
                reply.text = "Game initilialized ⚽"
            when /showlist/i
                reply.text = "admin"
                logger.info(gamectl.get_main_list)

                reply.text = "\n Liste des titulaires ***** \n"
                reply.text += gamectl.get_main_list
                reply.text += "\n Liste d'attente **********\n"
                reply.text += gamectl.get_waiting_list
            when /addme/i
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
            when /cancelme/i
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
            else 
                replying = false
            end      
        rescue => exception
            reply.text = "Internal error has occured ⚠️"

            logger.debug(gamectl.inspect)
            logger.debug(message.inspect)
            logger.error(exception)
        end 

        if replying
            puts "sending #{reply.text.inspect}"
            reply.send_with(bot)
        end
    end
end


