require_relative '../base'

class Command
    class PublicBase < Command::Base
        
        def execute
            run
        end 
    end
end