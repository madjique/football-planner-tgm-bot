require 'telegram_bot'
require 'logger'
require 'rufus-scheduler'
require 'require_all'
require 'date'

require_relative 'invoker'

require_all 'controllers/'

# Init logger
logger = Logger.new("log.txt")

# Init TGM Bot
token = ENV['FMP_BOT_TOKEN'] 
bot = TelegramBot.new(token: token)

# Default inits
gamectl = GameController.instance
playerctl = PlayerController.instance
invoker = CommandInvoker.instance

# Update Registrations State
Thread.new do
    gamectl.update_registrations
    gamectl.launch_automatic_registration_scheduler
end

# Main Loop

bot.get_updates(fail_silently: true) do |message|
    logger.info("recieving @#{message.from.username}: #{message.text}")
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
            when /confirm/i
                invoker.confirm_player_in_main_list(ctx)
            when /cancel_pending/i
                invoker.confirm_player_in_main_list(ctx)
            when /next_pending/i
                invoker.confirm_player_in_main_list(ctx)
            when /open_registrations/i
                invoker.open_registrations(ctx)
            when /close_registrations/i
                invoker.close_registrations(ctx)
            when /players/i
                invoker.show_all_players(ctx)
            else 
                replying = false
            end  
    
        rescue => exception
            reply.text = "Erreur Interne, contacte @madjidboudis ⚠️"

            logger.debug(gamectl.inspect)
            logger.debug(message.inspect)
            logger.error(exception)
        end 

        if replying
            logger.info("sending #{reply.text.inspect}")
            puts "sending #{reply.text.inspect}"
            reply.send_with(bot)
        end
    end
end
