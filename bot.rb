require 'telegram_bot'
require 'set'
require 'json'

token = ENV['FMP_BOT_TOKEN'] 

bot = TelegramBot.new(token: token)

players = Set.new

bot.get_updates(fail_silently: true) do |message|
    puts "@#{message.from.username}: #{message.text}"
    command = message.get_command_for(bot)

    message.reply do |reply|
        replying = true

        case command
        when /start/i
            reply.text = "This is a starting"
        when /hello/i
            reply.text = "Hello ⚽"
            puts players.inspect
        when /addme/i
            puts message.inspect
            if !players.include?(message.from.first_name)
                players << message.from.first_name
                reply.text = "#{message.from.first_name} added to the match ⚽"
            else
                reply.text = "#{message.from.first_name} already in match list ⚽"
            end
            puts players.inspect
        else 
            replying = false
        end

        if replying
            puts "sending #{reply.text.inspect}"
            reply.send_with(bot)
        end

    end
end


