require_relative 'dictionary.rb'
require_relative 'display.rb'

class Game
    attr_reader :dictionary, :aleatory_word, :hidden_word, :selection, :letter, :rounds
    include Dictionary
    include Display

    def initialize
        @welcome_message = welcome_message
        @game_selection = 0
    end

    def play
        start_game 
        game_over?
    end

    def select_aleatory_word(word_arr)
        word_index = Random.rand(0...word_arr.length)
        word_arr[word_index].downcase
    end

    def start_game
        play_or_load_message
        @game_selection = gets.chomp.to_i
        @game_selection == 1 ? new_game : "Under construction"
    end 

    def hidden_word(word)
        word.gsub(/[a-z]/, "_")
    end

    def new_game
        @rounds = 8
        @wrong_letter_arr = []
        @dictionary = filter_dictionary(WORDS)
        @aleatory_word = select_aleatory_word(@dictionary).chomp
        puts @aleatory_word
        @hidden_word = hidden_word(@aleatory_word)
        puts @aleatory_word
        @hidden_word_arr = @hidden_word.split("")
        puts @hidden_word
        start_round_message(@aleatory_word)
    end

    def play_round
        @letter = gets.chomp.downcase
    end

    def check_letter(choosen_letter, word)
        if word.include?(choosen_letter)
            word.split("").each_with_index do |letter, index|
                letter == choosen_letter ? @hidden_word[index] = letter : next
            end
        else
            @wrong_letter_arr.push(letter)
            @rounds -= 1
        end
        puts @hidden_word + "        Used letters: #{@wrong_letter_arr.join}"
        left_tries_message(@rounds)
    end

    def game_over?
        loop do
            play_round
            check_letter(@letter, @aleatory_word)
            if rounds == 0
                puts "You lose"
                break
            elsif @hidden_word.include?("_") == false
                puts "You win"
                break
            end
        end
    end


end

new_game = Game.new.play




