class Genre
    extend Concerns::Findable

    attr_accessor :name, :songs
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        genre = Genre.new(name)
        genre.save
        genre
    end

    def artists
        artist_arr = []
        Song.all.each do |s|
            if s.genre == self
                artist_arr << s.artist
            end
        end
        artist_arr.uniq
    end

end