require 'telegram_bot'
require "logger"
require_relative 'controllers/GameController'
require_relative 'commands'

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

        # Command's context 
        ctx = {
            message: message,
            reply: reply,
            logger: logger,
            gamectl: gamectl
        }

        begin
            case command
            when /hello/i
                hello_command(ctx)
            when /log/i
                admin_log(ctx)
            when /beginmatch/i
                begin_match_command(ctx)
            when /showlist/i
                show_list_command(ctx)
            when /addme/i
                add_player_to_game_command(ctx)
            when /cancelme/i
                cancel_player_from_game_command(ctx)
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


