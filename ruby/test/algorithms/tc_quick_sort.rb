# frozen_string_literal: true
require_relative "../../algorithms/quick_sort"
require "test/unit"

class TestQuickSort < Test::Unit::TestCase
  def test_sort_empty
    sorted = QuickSort.sort([])
    assert_equal([], sorted)
  end

  def test_sort_single
    sorted = QuickSort.sort([4])
    assert_equal([4], sorted)
  end

  def test_sort_two
    sorted_1 = QuickSort.sort([1, 4])
    sorted_2 = QuickSort.sort([4, 1])

    assert_equal([1, 4], sorted_1)
    assert_equal([1, 4], sorted_2)
  end

  def test_sort_many
    sorted = QuickSort.sort([5, 6, 4, 7, 3, 8, 2, 9, 1])
    assert_equal([1, 2, 3, 4, 5, 6, 7, 8, 9], sorted)
  end
end
