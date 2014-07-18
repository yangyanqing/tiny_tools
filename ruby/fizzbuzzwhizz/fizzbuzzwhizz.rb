#!/usr/bin/env ruby

def FbwSay(specials, number)
    @words_list = ['Fizz', 'Buzz', 'Whizz']
    @words_to_say = ''

    (0...specials.size).each { |i|
        @words_to_say += @words_list[i] if number % specials[i] == 0
    }
    return @words_to_say if @words_to_say != ''
    number.to_s
end

