require_relative 'dictionary.rb'
require_relative 'display.rb'
require 'yaml'
require 'colorize'

class Game
    attr_reader :dictionary, :aleatory_word, :hidden_word, :selection, :letter, :rounds, :wrong_letter_string, :hidden_word_arr, :file_name
    include Dictionary
    include Display

    def initialize(aleatory_word = "", rounds = 8, wrong_letter_string = "", hidden_word = "", hidden_word_arr = [], letter = "", file_name = "")
        if aleatory_word == ""
            @welcome_message = welcome_message
            new_game
        else
            @aleatory_word = aleatory_word
            @rounds = rounds
            @wrong_letter_string = wrong_letter_string
            @hidden_word = hidden_word
            @hidden_word_arr = hidden_word_arr
            @letter = letter
            @file_name = file_name
            puts @hidden_word.green + "        Used letters: #{@wrong_letter_string.red}"
            left_tries_message(@rounds)
            game_over?
        end
    end

    def select_aleatory_word(word_arr)
        word_index = Random.rand(0...word_arr.length)
        word_arr[word_index].downcase
    end

    def hidden_word(word)
        word.gsub(/[a-z]/, "_")
    end

    def new_game
        @rounds = 8
        @wrong_letter_string = ""
        @dictionary = filter_dictionary(WORDS)
        @aleatory_word = select_aleatory_word(@dictionary).chomp
        @hidden_word = hidden_word(@aleatory_word)
        @hidden_word_arr = @hidden_word.split("")
        @file_name = ""
        puts @hidden_word.green + "        Used letters: #{@wrong_letter_string.red}"
        start_round_message(@aleatory_word)
        game_over?
    end

    def play_round
        @letter = gets.chomp.downcase
        if @letter == 'save'
            save_game
            #HAy que modificar la línea siguiente para que no deje meter algo distinto a una letra
        elsif @letter.length > 1 || @letter != /[a-z]/ || @wrong_letter_string.include?("#{@letter}")
            enter_right_value
            play_round
        end
    end

    def check_letter(choosen_letter, word)
        if word.include?(choosen_letter)
            word.split("").each_with_index do |letter, index|
                letter == choosen_letter ? @hidden_word[index] = letter : next
            end
        else
            @wrong_letter_string += letter.red
            @rounds -= 1
        end
        puts @hidden_word.green + "        Used letters: #{@wrong_letter_string}"
        left_tries_message(@rounds)
    end

    def game_over?
        loop do
            play_round
            check_letter(@letter, @aleatory_word) unless @rounds < 0
            if @rounds == 0
                puts "\nYou lose"
                break
            elsif @hidden_word.include?("_") == false
                puts "\nYou win"
                if @file_name == ""
                    break
                else
                    File.delete("#{@file_name}")
                    break
                end
            elsif @rounds < 0
                break
            end
        end
    end

    def serialize
        YAML.dump({
            :aleatory_word => @aleatory_word,
            :rounds => @rounds,
            :wrong_letter_string => @wrong_letter_string,
            :hidden_word => @hidden_word,
            :hidden_word_arr => @hidden_word_arr,
            :letter => @letter,
            :file_name => @file_name
        })
    end

    def save_game
        puts "\nWhat's the name of your game?"
        game_file = gets.chomp
        saved_game_dir = "saved_games"
        Dir.mkdir(saved_game_dir) unless File.exists?saved_game_dir
        saved_game = File.open("#{saved_game_dir}/#{game_file}.yaml", "w")
        @file_name = "#{saved_game_dir}/#{game_file}.yaml"
        saved_game.write serialize
        puts "\nGame saved. Thank you for playing The Hangman :)"
        @rounds = -1
    end

    def self.deserialize(string)
        data = YAML.load string
        self.new(data[:aleatory_word], data[:rounds], data[:wrong_letter_string], data[:hidden_word], data[:hidden_word_arr], data[:letter], data[:file_name])
    end
end




