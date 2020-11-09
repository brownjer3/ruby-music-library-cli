class Artist
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
        artist = Artist.new(name)
        artist.save
        artist
    end

    # def songs
    #     Song.all.select {|s| s.artist == self}
    # end

    def add_song(song_obj)
        if song_obj.artist.nil?
            song_obj.artist = self
            self.songs << song_obj
        end
    end

    def genres
        genre_arr = []
        Song.all.each do |s|
            if s.artist == self
                genre_arr << s.genre
            end
        end
        genre_arr.uniq
    end 

end