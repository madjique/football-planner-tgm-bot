require 'set'

class Player
    attr_reader :fullname
    @@players = Set.new

    def initialize(name)
        @fullname = name
        @@players << self
    end
    
    def to_s
        fullname
    end

    def get_fullname
        fullname
    end

    def self.all
        @@players
    end
end