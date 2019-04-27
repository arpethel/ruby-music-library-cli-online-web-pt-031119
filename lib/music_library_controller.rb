require "pry"
class MusicLibraryController

  extend Concerns::Findable

  def initialize(path = "./db/mp3s")
    new_importer_object = MusicImporter.new(path)
    new_importer_object.import
  end

  def call
    input = ""
    while input != "exit"
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

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end

    end
  end

  def list_songs
# #begin
#     Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
#         puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
#       end
# #end

    songs_sorted_by_name = Song.all.sort_by {|song| song.name}

    songs_sorted_by_name.each.with_index(1) {|song,index| puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    songs_sorted_by_artist = Artist.all.sort_by {|artist| artist.name}
    songs_sorted_by_artist.each.with_index(1) {|artist,index| puts "#{index}. #{artist.name}"}
  end

  def list_genres
    songs_sorted_by_genre = Genre.all.sort_by {|genre| genre.name}
    songs_sorted_by_genre.each.with_index(1) {|genre,index| puts "#{index}. #{genre.name}"}
  end


  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if artist = Artist.find_by_name(input)
      songs_sorted_by_name = artist.songs.sort_by {|song| song.name}
      songs_sorted_by_name.each.with_index(1) {|song,index| puts "#{index}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if genre = Genre.find_by_name(input)
      songs_sorted_by_name = genre.songs.sort_by {|song| song.name}
      songs_sorted_by_name.each.with_index(1) {|song,index| puts "#{index}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip
    list_of_songs =  Song.all.sort do |a, b|
      # binding.pry
      a.name <=> b.name
    end

# MusicLibraryController - CLI Methods #play_song upon receiving valid input 'plays' the matching song from the alphabetized list output by #list_songs

    # input = gets.strip.to_i

    if (1..Song.all.length).include?(input)
      # binding.pry
      song = list_of_songs[input+2]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end
