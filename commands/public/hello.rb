require_relative 'public_base'

class Command
    class HelloCommand < Command::PublicBase
        def run
            respond("Hello ⚽")
        end
    end
end