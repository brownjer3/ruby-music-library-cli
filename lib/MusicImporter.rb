class MusicImporter
    attr_accessor :path

    def initialize(path)
        @path = path
    end 

    def files
        files = Dir["#{@path}/**/*.mp3"]
        files.collect {|f| f.delete_prefix("#{path}/")}
    end

    def import
        self.files.each do |f|
            Song.create_from_filename(f)
        end
    end

end