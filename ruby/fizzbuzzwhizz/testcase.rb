#!/usr/bin/env ruby

require_relative 'fizzbuzzwhizz.rb'
require 'test/unit'

class TestFbwSay < Test::Unit::TestCase
    def setup
        @specials = [3, 5, 7]
    end

    def teardown
    end

    def self.define_test(expect, given)
        define_method("test_Given_#{given.to_s}_should_say_#{expect}") {
            assert_equal(expect, FbwSay(@specials, given)) 
        } 
    end

    define_test('1', 1)
    define_test('Fizz', 3)
    define_test('Buzz', 5)
    define_test('Whizz', 7)
    define_test('FizzBuzz', 15)
    define_test('FizzBuzzWhizz', 105)
end

