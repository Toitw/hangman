module Display
    def welcome_message
        puts "\nWelcome to The Hangman! Instructions are the following:\n \
        A random 5 to 12 letter long word it's been generated while you read :) \n \
        Your mission is to find out which word it is. In order to discover it, \n \
        you will choose a letter every round. The computer will tell you if the letter \n \
        is within the word and display it for you to see in which position is it. \n \
        If the letter is not in the word, you will see it displayed outside of the word. \n\n \
        You can only fail the letter 8 times!! A counter will be displayed. \n\n \
        Have fun :)\n\n"
    end

    def play_or_load_message
        puts "\nEnter '1' to start a new game or '2' to load one saved game"
    end

    def start_round_message(word)
        puts "\nThe hidden word is #{word.length} letters long. Choose a letter and try to find it out"
    end

    def left_tries_message(rounds_left)
        puts "\nYou have #{rounds_left} rounds left. Choose one more letter or press 'save' to save the game"
    end

    def load_game_message
        puts "\nWrite down the name of the game you want to load"
    end

    def enter_right_value
        puts "\nPlease, enter just 1 letter, not used already, or enter 'save' to save the game"
    end
        
end
