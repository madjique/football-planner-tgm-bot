require 'set'

class Player
    attr_reader :fullname, :username, :score
    @@players = Set.new

    def initialize(name,username)
        @fullname = name
        @username = username
        @score = 0
        @@players << self
    end
    
    def to_s
        username
    end

    def self.all
        @@players
    end

    # Getters

    def get_fullname
        fullname
    end
    
    def get_username
        username
    end

    def get_score
        score
    end

    # Setters

    def set_score(value)
        score = value
    end

end