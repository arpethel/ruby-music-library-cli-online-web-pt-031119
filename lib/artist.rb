require 'pry'

require_relative './concerns/findable'

class Artist
  extend Concerns::Findable
  attr_accessor :name#, :artist
  @@all = []

  def initialize(name)
    @name = name
    @artist = artist
    @songs = []
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
    artist = self.new(name)
    artist.save
    artist
  end

  ##########
  def songs
    @songs
  end

  def add_song(song)
    # binding.pry
    @songs << song if @songs.include?(song) == false
    song.artist ||= self
  end

  def genres
    songs.map { |song| song.genre }.uniq
  end

end
