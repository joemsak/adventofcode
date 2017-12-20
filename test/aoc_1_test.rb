require "minitest/autorun"

class Aoc1Test < Minitest::Test
  def test_it_sums_digits_that_match_the_next_in_sequence
    assert_equal 3, solve_captcha(1122)
  end

  def test_it_sums_digits_that_match_on_the_ends
    assert_equal 4, solve_captcha(1111)
  end

  def test_it_returns_0_for_sequences_without_repeating_digits
    assert_equal 0, solve_captcha(1234)
  end

  def test_it_returns_the_only_digit_that_repeats
    assert_equal 9, solve_captcha(91212129)
  end

  def solve_captcha(sequence)
    scannable_seq = ScannableSequence.new(sequence)

    scannable_seq.each.with_index.reduce(0) do |acc, (d, i)|
      scannable_seq.sum_matching_digits(acc, d, i)
    end
  end

  class ScannableSequence
    include Enumerable

    attr_reader :scannable

    def initialize(sequence)
      @scannable = sequence.to_s.split("")
    end

    def each(&block)
      scannable.each(&block)
    end

    def sum_matching_digits(acc, digit, index)
      if next_digit_matches?(digit, index)
        acc + digit.to_i
      else
        acc
      end
    end

    private
    def next_digit_matches?(digit, index)
      next_digit_index = index + 1
      next_digit_index = 0 if scannable[next_digit_index].nil?

      digit === scannable[next_digit_index]
    end
  end
end
