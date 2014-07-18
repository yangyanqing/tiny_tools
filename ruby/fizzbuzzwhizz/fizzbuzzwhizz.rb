#!/usr/bin/env ruby

def FbwSay(specials, number)
    @words_list = ['Fizz', 'Buzz', 'Whizz']

    (0...specials.size).each { |i|
        return @words_list[i] if number % specials[i] == 0
    }
    number.to_s
end

