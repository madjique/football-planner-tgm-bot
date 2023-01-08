require_relative 'base'

class Command
    class HelloCommand < Command::Base
        def run
            respond("Hello ⚽")
        end
    end
end