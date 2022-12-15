require_relative 'dictionary.rb'
require_relative 'display.rb'
require_relative 'game.rb'
require 'yaml'
require 'colorize'

include Display

def play
    Display::play_or_load_message
    @game_selection = gets.chomp.to_i
    @game_selection == 1 ? Game.new : load_game
end 

def load_game
    #Two next lines shows the saved games without the extension
    files = Dir.glob('saved_games/*')
    files.map {|file| puts File.basename(file, ".*")}
    load_game_message
    file_name = gets.chomp
    game_file = File.read("saved_games/#{file_name}.yaml")
    Game.deserialize(game_file)
end

play

