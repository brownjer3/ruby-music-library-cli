require 'pry'
class Song
    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        #@artist = artist
        if !artist.nil?
            self.artist = artist
        end
        if !genre.nil?
            self.genre = genre
        end
        self.save
    end

    def self.all
        @@all.uniq
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        @artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        if !@genre.songs.include?(self)
            @genre.songs << self
        end
    end

    def self.find_by_name(name)
        self.all.find {|s| s.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || Song.create(name)
    end

    def self.new_from_filename(filename)
        parsed = filename.split(" - ")
        song = Song.create(parsed[1])
        song.artist = Artist.find_or_create_by_name(parsed[0])
        song.genre = Genre.find_or_create_by_name(parsed[2].chomp(".mp3"))
        song
    end

    def self.create_from_filename(filename)
        song = new_from_filename(filename)
        song.save
    end

end