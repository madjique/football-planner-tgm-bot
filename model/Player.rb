require 'set'

class Player
    attr_reader :fullname, :username
    @@players = Set.new

    def initialize(name,username)
        @fullname = name
        @username = username
        @@players << self
    end
    
    def to_s
        username
    end

    def get_fullname
        fullname
    end
    
    def get_username
        username
    end

    def self.all
        @@players
    end

end