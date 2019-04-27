require 'pry'

class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    @genre = genre
    self.artist = artist unless artist.nil?
    self.genre = genre unless genre.nil?
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    self.new(name).tap {|song| song.save}
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap {|song| song.save }
  end

  def self.new_from_filename(filename)
    song_name = filename.split(" - ")[1]
    artist_name = filename.split(" - ")[0]
    genre_name = filename.split(" - ")[2].gsub('.mp3', '')

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    self.new(song_name, artist, genre)
  end

  ##########
  def artist
    @artist
  end

  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end

  def genre
    @genre
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if genre.songs.include?(self) == false
  end
end
