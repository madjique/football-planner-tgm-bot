class Command
    class Base
        attr_reader :gamectl, :message, :reply, :logger
        
        def initialize(ctx)
            @gamectl = ctx[:gamectl]
            @message = ctx[:message]
            @reply = ctx[:reply]
            @logger = ctx[:logger]
        end
    end
end