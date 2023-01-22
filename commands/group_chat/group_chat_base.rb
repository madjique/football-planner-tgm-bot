require_relative '../base'

class Command
    class GroupChatBase < Command::Base
        def match_group_requirements?
            private_group_chat = (message.chat.id == group_chat_id)
            admin? or (private_group_chat and requester_fullname and requester_username)
        end

        def execute
            if match_group_requirements?
                run
            else
                respond("Vous ne satisfiez pas les conditions pour effectuer cette Action\n( Assurez-vous d'avoir un username et un Prénom, et d'etre sur le bon groupe )")
            end
        end 
    end
end