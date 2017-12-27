require "minitest/autorun"
require "csv"

class Aoc2Test < Minitest::Test
  def test_it_finds_the_highest_value_in_each_row
    rows = [[1, 2, 3], [4, 5, 6]]
    assert_equal({ 0 => 3, 1 => 6 }, Checksum.new(rows).each_row_max)
  end

  def test_it_finds_the_lowest_value_in_each_row
    rows = [[1, 2, 3], [4, 5, 6]]
    assert_equal({ 0 => 1, 1 => 4 }, Checksum.new(rows).each_row_min)
  end

  def test_it_returns_the_difference_in_each_row
    rows = [[1, 2, 3], [4, 5, 6]]
    assert_equal({ 0 => 2, 1 => 2 }, Checksum.new(rows).each_row_diff)
  end

  def test_it_returns_the_checksum_string
    rows = [[1, 2, 3], [4, 5, 6]]
    assert_equal("4", Checksum.new(rows).to_s)
  end
end

class Checksum
  attr_reader :rows

  def initialize(rows)
    @rows = rows.map { |r| r.map(&:to_i) }
  end

  def to_s
    each_row_diff.values.sum.to_s
  end

  def each_row_diff
    each_row_max.reduce({}) do |h, (k, _)|
      h.update(k => each_row_max[k] - each_row_min[k])
    end
  end

  def each_row_max
    select_rows_by(&:max)
  end

  def each_row_min
    select_rows_by(&:min)
  end

  private
  def select_rows_by(&block)
    rows.each.with_index.reduce({}) do |hash, (row, index)|
      hash.update(index => yield(row))
    end
  end
end

rows = CSV.read("aoc_2_input", col_sep: "\t")
puts Checksum.new(rows)
