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

    def self.get_player(fullname,username)
        player = existing_player(username)
        return player if player
        return new(fullname,username)
    end

    def existing_player(username)
        players.find { |player| player.to_s == username }
    end
end