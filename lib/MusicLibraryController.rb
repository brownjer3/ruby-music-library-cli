class MusicLibraryController

    def initialize(path = "./db/mp3s")
        MusicImporter.new(path).import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        
        input = gets.strip

        if input == "list songs"
            list_songs
        end
        if input == "list artists"
            list_artists
        end
        if input == "list genres"
            list_genres
        end
        if input == "list artist"
            list_songs_by_artist
        end
        if input == "list genre"
            list_songs_by_genre
        end
        if input == "play song"
            play_song
        end

        until input == "exit" do
            puts "What would you like to do?"
            input = gets.strip
        end


    end

    def list_songs
        sorted = Song.all.sort_by {|s| s.name}
        sorted.each_with_index do |s, i|
            puts "#{i+1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
        end
    end

    def list_artists
        sorted = Artist.all.sort_by {|s| s.name}
        sorted.each_with_index do |s, i|
            puts "#{i+1}. #{s.name}"
        end
    end

    def list_genres
        sorted = Genre.all.sort_by {|s| s.name}
        sorted.each_with_index do |s, i|
            puts "#{i+1}. #{s.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        req_artist = Artist.find_or_create_by_name(input)

        #binding.pry
        found = Song.all.select {|s| s.artist == req_artist}
        sorted = found.sort_by{|s| s.name}
        sorted.each_with_index do |s, i|
            puts "#{i+1}. #{s.name} - #{s.genre.name}"
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        req_genre = Genre.find_or_create_by_name(input)

        #binding.pry
        found = Song.all.select {|s| s.genre == req_genre}
        sorted = found.sort_by{|s| s.name}
        sorted.each_with_index do |s, i|
            puts "#{i+1}. #{s.artist.name} - #{s.name}"
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        sorted = Song.all.sort_by {|s| s.name}

        if input.between?(1,sorted.length)
            puts "Playing #{sorted[input-1].name} by #{sorted[input-1].artist.name}"
        end

    end


end