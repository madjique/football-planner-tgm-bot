require 'telegram/bot'
require 'logger'
require 'rufus-scheduler'
require 'require_all'
require 'date'
require 'dotenv'

require_relative 'invoker'

# Load .env file 
Dotenv.load

require_all 'controllers/'

# Init logger
logger = Logger.new("log.txt")

# Init TGM Bot
token = ENV['FMP_BOT_TOKEN']
group_chat_id =  ENV['GROUP_CHAT_ID'].to_i
admin_list = ENV['ADMINS']

# Default inits
gamectl = GameController.instance
playerctl = PlayerController.instance
invoker = CommandInvoker.instance

Telegram::Bot::Client.run(token) do |bot|

    # Update Registrations State
    Thread.new do
        gamectl.set_bot_ctx(group_chat_id, bot.api)
        gamectl.update_registrations
        gamectl.launch_automatic_registration_scheduler
    end

    # Main Loop
    bot.listen do |message|
        begin
            command = message.text&.split('@')[0]
            reply = {}
            replying = true

            # Loading command's context 
            invoker.load_context({
                message: message,
                reply: reply,
                logger: logger,
                gamectl: gamectl,
                playerctl: playerctl,
                group_chat_id: group_chat_id,
                admin_list: admin_list
            })

            case command
            when /^\/hello\s*$/i
                invoker.hello
            when /^\/log\s*$/i
                invoker.log
            when /^\/beginmatch\s*$/i
                invoker.begin_match
            when /^\/showlist\s*$/i
                invoker.show_list
            when /^\/addme\s*$/i
                invoker.add_player_to_game
            when /^\/cancelme\s*$/i
                invoker.cancel_player_from_game
            when /^\/canceIme\s*$/i
                invoker.cancel_player_from_game
            when /^\/confirm\s*$/i
                invoker.confirm_player_to_main_list
            when /^\/next_pending\s*$/i
                invoker.move_from_waiting_list_to_pending
            when /^\/open_registrations\s*$/i
                invoker.open_registrations
            when /^\/close_registrations\s*$/i
                invoker.close_registrations
            when /^\/load_players\s*$/i
                invoker.load_group_players
            when /^\/cancel_pending\s*$/i
                invoker.cancel_pending_player
            when /^\/players\s*$/i
                invoker.show_all_players
            else 
                replying = false
            end 

            if replying
                logger.info("recieving @#{message.from.username}: #{command}")
                puts "@#{message.from.username}: #{command}"
                logger.info("sending #{reply[:text]}")
                puts "sending #{reply[:text]}"
                    
                bot.api.send_message(chat_id: message.chat.id, text: reply[:text])
            end
    
        rescue => exception
            logger.debug(gamectl.inspect)
            logger.debug(playerctl.inspect)
            logger.debug(message.inspect)
            logger.error(exception)
            puts exception
         
            begin
                bot.api.send_message(chat_id: message.chat.id, text: "Erreur interne, contactez l'admin ⚠️")
            rescue => exception
                logger.error(exception)
            end
        end
    end
end
