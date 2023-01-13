require 'telegram_bot'
require 'logger'
require 'require_all'

require_relative 'invoker'

require_all 'controllers/'

# Init logger
logger = Logger.new(STDOUT)

# Init TGM Bot
token = ENV['FMP_BOT_TOKEN'] 
bot = TelegramBot.new(token: token)

# Default inits
gamectl = GameController.instance
playerctl = PlayerController.instance
invoker = CommandInvoker.instance

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
            gamectl: gamectl,
            playerctl: playerctl
        }

        begin
            case command
            when /hello/i
                invoker.hello(ctx)
            when /log/i
                invoker.log(ctx)
            when /beginmatch/i
                invoker.begin_match(ctx)
            when /showlist/i
                invoker.show_list(ctx)
            when /addme/i
                invoker.add_player_to_game(ctx)
            when /cancelme/i
                invoker.cancel_player_from_game(ctx)
            when /players/i
                invoker.show_all_players(ctx)
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


