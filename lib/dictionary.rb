
module Dictionary
    WORDS = File.readlines("google-10000-english-no-swears.txt")

    def filter_dictionary(raw_dictionary)
        raw_dictionary.select {|word| word.length > 5 && word.length < 12}
    end

end
