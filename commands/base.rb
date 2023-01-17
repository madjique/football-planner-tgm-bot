class Command
    class Base
        attr_reader :gamectl, :message, :reply, :logger, :playerctl, :requester_fullname, :requester_username
        
        def initialize(ctx)
            @gamectl = ctx[:gamectl]
            @message = ctx[:message]
            @reply = ctx[:reply]
            @logger = ctx[:logger]
            @playerctl = ctx[:playerctl]
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
            reply.text = text
        end

        def respond_multiple(text_arr)
            reply.text = ''

            text_arr.each do |txt|
                reply.text+= txt
            end 
        end

        def run
            respond("Cette fonctionalitée n'est pas encore implémentée ❌")
        end

        def match_requirements?
            foot_clignacourt_group_chat= (message.chat.id == -1001527306990)
            admin? or (foot_clignacourt_group_chat and requester_fullname and requester_username)
        end

        def admin?
            #TODO : Add dynamic admin liste
            requester_username == 'madjidboudis'
        end

        def execute
            run
        end 

        def execute_with_checks
            if match_requirements?
                run
            else
                respond("Vous ne satisfiez pas les conditions pour effectuer cette Action\n( Assurez-vous d'avoir un username et un Prénom )")
            end
        end 

        def execute_with_admin
            if admin?
                run
            else
                respond("Vous n'avez pas les droits d'effectuer cette opération ❌")
            end
        end 
    end
end