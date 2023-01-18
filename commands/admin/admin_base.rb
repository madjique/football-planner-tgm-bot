require_relative '../base'

class Command
    class AdminBase < Command::Base
        def execute
            if admin?
                run
            else
                respond("Vous n'avez pas les droits d'effectuer cette opération ❌")
            end
        end 
    end
end