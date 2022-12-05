require_relative 'dictionary.rb'

class Game
    attr_reader :dictionary, :aleatory_word
    include Dictionary

    def initialize
        @dictionary = filter_dictionary(WORDS)
        @aleatory_word = select_aleatory_word(@dictionary)
    end

    def select_aleatory_word(word_arr)
        word_index = Random.rand(0...word_arr.length)
        word_arr[word_index]
    end
end

new_game = Game.new
puts new_game.aleatory_word



