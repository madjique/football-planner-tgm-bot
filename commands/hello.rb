require_relative 'base'

class Command
    class HelloCommand < Command::Base
        def run
            reply.text = "Hello ⚽"
        end
    end
end