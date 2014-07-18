#!/usr/bin/env ruby

def FbwSay(specials, number)
    return 'Fizz' if number % 3 == 0
    return 'Buzz' if number % 5 == 0
    number.to_s
end

