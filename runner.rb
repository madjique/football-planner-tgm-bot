require 'telegram_bot'
require 'logger'
require 'require_all'

require_all 'commands/'
require_all 'controllers/'

# Init logger
logger = Logger.new(STDOUT)

# Init TGM Bot
token = ENV['FMP_BOT_TOKEN'] 
bot = TelegramBot.new(token: token)

# Default inits
gamectl = GameController.new
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
                Command::HelloCommand.new(ctx).run
            when /log/i
                Command::AdminLogCommand.new(ctx).run
            when /beginmatch/i
                Command::BeginMatchCommand.new(ctx).run
            when /showlist/i
                Command::ShowListCommand.new(ctx).run
            when /addme/i
                Command::AddPlayerToGameCommand.new(ctx).run
            when /cancelme/i
                Command::CancelPlayerFromGameCommand.new(ctx).run
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


