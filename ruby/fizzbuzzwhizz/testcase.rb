#!/usr/bin/env ruby

require_relative 'fizzbuzzwhizz.rb'
require 'test/unit'

class TestFbwSay < Test::Unit::TestCase
    def setup
        @specials = [3, 5, 7]
    end

    def teardown
    end

    def test_Give_1_should_say_1
        assert_equal('1', FbwSay(@specials, 1))
    end

    def test_Give_3_should_say_Fizz
        assert_equal('Fizz', FbwSay(@specials, 3))
    end
    
    def test_Give_5_should_say_Buzz
        assert_equal('Buzz', FbwSay(@specials, 5))
    end
end

