require_relative '../base'

class Command
    class GroupChatBase < Command::Base
        def match_group_requirements?
            foot_clignacourt_group_chat= (message.chat.id == -1001527306990)
            admin? or (foot_clignacourt_group_chat and requester_fullname and requester_username)
        end

        def execute
            if match_group_requirements?
                run
            else
                respond("Vous ne satisfiez pas les conditions pour effectuer cette Action\n( Assurez-vous d'avoir un username et un Prénom )")
            end
        end 
    end
end