require 'json'
require_relative 'board'

class Store
  attr_reader :playlists
  
  def initialize(filename)
    @filename = filename
    @tasks = load_list
  end

  def load_list
    JSON.parse(File.read(@filename), symbolize_names: true).map do |list|
      Board.new(name: list[:name], description: list[:description], lists: list[:lists], id: list[:id])
    end
  end

  def update_b(id, data)
    found_board=@tasks.find {|list| list.id == id}
    found_board=update_board(data)
    File.write(@filename, @tasks.to_json)
  end

  # def append_playlist(playlist)
  #   @playlists << playlist
  #   File.write(@filename, @playlists.to_json)
  # end

  # def update_playlist(id, data)
  #   found_playlist = find_list(id)
  #   found_playlist.update(data)
  #   File.write(@filename, @playlists.to_json)
  # end

  # def remove_playlist(id)
  #   @playlists.select! { |list| list.id != id.to_i }
  #   File.write(@filename, @playlists.to_json)
  # end

  # def find_list(id)
  #   @playlists.find { |list| list.id == id.to_i }
  # end

  # def find_song(list, id)
  #   list.songs.find { |song| song.id == id.to_i }
  # end

  # def append_song(list, song)
  #   list.songs << song
  #   File.write(@filename, @playlists.to_json)
  # end

  # def remove_song(list, id)
  #   list.songs.delete_if { |song| song.id == id.to_i }
  #   File.write(@filename, @playlists.to_json)
  # end

  # def update_song(list, id, data)
  #   found_song = find_song(list, id)
  #   found_song.update(data)
  #   File.write(@filename, @playlists.to_json)
  # end

end

nuevo = Store.new("store.json")
# p nuevo
