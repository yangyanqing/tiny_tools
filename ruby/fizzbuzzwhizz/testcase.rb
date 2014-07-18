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
end

