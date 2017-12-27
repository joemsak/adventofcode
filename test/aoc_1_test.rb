require "minitest/autorun"

class Aoc1Test < Minitest::Test
  def test_it_sums_digits_that_match_the_next_in_sequence
    assert_equal 3, SolveCaptcha.("1122\n")
  end

  def test_it_sums_digits_that_match_on_the_ends
    assert_equal 4, SolveCaptcha.(1111)
  end

  def test_it_returns_0_for_sequences_without_repeating_digits
    assert_equal 0, SolveCaptcha.(1234)
  end

  def test_it_returns_the_only_digit_that_repeats
    assert_equal 9, SolveCaptcha.(91212129)
  end

  def test_it_chomps_file_reads
    assert_equal 1, SolveCaptcha.("1231\n")
  end
end

module SolveCaptcha
  def self.call(sequence)
    scannable_seq = ScannableSequence.new(sequence)

    matches = scannable_seq.select.with_index do |d, i|
      scannable_seq.next_digit_matches?(d, i)
    end

    matches.sum
  end

  class ScannableSequence
    include Enumerable

    attr_reader :scannable

    def initialize(sequence)
      @scannable = sequence.to_s.chomp.chars.map(&:to_i)
    end

    def each(&block)
      scannable.each(&block)
    end

    def next_digit_matches?(digit, index)
      next_index = index + 1
      next_index = 0 if next_index == scannable.size
      digit == scannable[next_index]
    end
  end
end
