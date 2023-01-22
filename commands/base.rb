class Command
    class Base
        attr_reader :gamectl, :message, :reply, :logger, :playerctl, :requester_fullname, :requester_username, :group_chat_id, :admin_list
        
        def initialize(ctx)
            @gamectl = ctx[:gamectl]
            @message = ctx[:message]
            @reply = ctx[:reply]
            @logger = ctx[:logger]
            @playerctl = ctx[:playerctl]
            @group_chat_id = ctx[:group_chat_id]
            @admin_list = ctx[:admin_list]
            @requester_fullname = "#{message.from.first_name} #{message.from.last_name}" || nil
            @requester_username = message.from.username || nil
        end

        def reload_context(ctx)
            initialize(ctx)
        end

        def log_info(info)
            logger.info(info)
        end

        def log_info_multiple(info_arr)
            info_arr.each do |txt|
                log_info(txt)
            end 
        end

        def respond(text)
            reply[:text] = text
        end

        def respond_multiple(text_arr)
            reply[:text] = ''

            text_arr.each do |txt|
                reply[:text] += txt
            end 
        end

        def admin?
            admin_list.include?(requester_username)
        end
        
        def run
            respond("Cette fonctionalitée n'est pas encore implémentée ❌")
        end
    end
end