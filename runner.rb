require 'telegram_bot'
require "logger"
require_relative 'controllers/GameController'


logger = Logger.new(STDOUT)

token = ENV['FMP_BOT_TOKEN'] 
bot = TelegramBot.new(token: token)
gamectl = GameController.new

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
                logger.info(players.inspect)
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
            when /addme/i
                player = Player.new("#{message.from.first_name} #{message.from.last_name}")
                logger.info(gamectl.inspect)
                if gamectl.get_players&.include?(player)
                    reply.text = "#{player.fullname} already in match list! ❌"
                else
                    gamectl.add_player(player)
                    reply.text = "#{player.fullname} added to the match ✅ ⚽"
                end
                logger.info(players.inspect)
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


