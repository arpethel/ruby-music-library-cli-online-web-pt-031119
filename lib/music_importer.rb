require 'pry'

class MusicImporter
  attr_accessor :path

  def initialize(filepath)
    @path = filepath
  end

  def files
    @files ||= Dir.glob("#{@path}/*.mp3").map{|file| file.gsub("#{@path}/", "") }
  end

  def import
    files.each{ |filename| Song.create_from_filename(filename) }
  end
end
