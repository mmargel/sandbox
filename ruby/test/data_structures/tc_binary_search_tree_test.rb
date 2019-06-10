# frozen_string_literal: true
require_relative "../../data_structures/binary_search_tree"
require "test/unit"

class TestBinarySearchTree < Test::Unit::TestCase
  def setup
    @tree = BinarySearchTree.new
  end

  # insert
  def test_insert_nil
    assert_raise(ArgumentError) { @tree.insert(nil) }
  end

  def test_insert_valid
    #     2
    #   /   \
    #  1     4
    #       /
    #      3
    item_2 = @tree.insert(2)
    item_4 = @tree.insert(4)
    item_1 = @tree.insert(1)
    item_3 = @tree.insert(3)

    assert_equal(2, item_2.value)
    assert_equal(4, item_4.value)
    assert_equal(4, item_3.parent.value)
    assert_equal(2, item_4.parent.value)
    assert_equal(2, item_1.parent.value)
  end

  # empty
  def test_empty_true
    assert(@tree.empty?)
  end

  def test_empty_false
    @tree.insert(3)
    assert(!@tree.empty?)
  end

  def test_empty_removed
    @tree.insert(3)
    @tree.remove(3)
    assert(@tree.empty?)
  end

  # find
  def test_find_nil
    assert_raise(ArgumentError) { @tree.find(nil) }
  end

  def test_find_match
    @tree.insert(5)
    @tree.insert(4)
    @tree.insert(3)
    @tree.insert(8)
    @tree.insert(6)
    assert_equal(4, @tree.find(4).value)
  end

  def test_find_no_match
    @tree.insert(1)
    @tree.insert(2)
    @tree.insert(3)
    assert_nil(@tree.find(4))
  end

  # leaf?
  def test_is_leaf
    d = @tree.insert(4)
    e = @tree.insert(5)

    assert(!d.leaf?)
    assert(e.leaf?)
  end

  # remove
  def test_remove_nil
    assert_raise(ArgumentError) { @tree.remove(nil) }
  end

  def test_remove_leaf
    #      5
    #    /  \
    #   4    6
    #  /
    # 3
    @tree.insert(5)
    @tree.insert(4)
    @tree.insert(3)
    @tree.insert(6)
    @tree.remove(3)

    assert(@tree.find(5).root?)
    assert(@tree.find(4).leaf?)
    assert(@tree.find(6).leaf?)
  end

  def test_remove_root
    #      5
    #    /  \
    #   4    6
    #  /
    # 3
    @tree.insert(5)
    @tree.insert(4)
    @tree.insert(3)
    @tree.insert(6)
    @tree.remove(5)

    assert(@tree.find(6).root?)
    assert_equal(6, @tree.find(4).parent.value)
    assert_equal(4, @tree.find(3).parent.value)
    assert_equal(3, @tree.find(4).left.value)
    assert_equal(4, @tree.find(6).left.value)
  end

  def test_remove_middle
    #      5
    #    /  \
    #   4    6
    #  /
    # 3
    @tree.insert(5)
    @tree.insert(4)
    @tree.insert(3)
    @tree.insert(6)
    @tree.remove(4)

    assert(@tree.find(3).leaf?)
    assert(@tree.find(6).leaf?)
    assert(@tree.find(5).root?)
    assert_equal(5, @tree.find(3).parent.value)
    assert_equal(3, @tree.find(5).left.value)
  end

  def test_remove_complex
    @tree.insert(5)
    # 
    @tree.insert(3)
    @tree.insert(7)
    # 
    @tree.insert(2)
    @tree.insert(4)
    @tree.insert(6)
    @tree.insert(8)
    #
    @tree.insert(1)

    @tree.remove(5)
    assert_equal([6, 3, 2, 1, 4, 7, 8], @tree.traverse_pre)
    assert_equal([1, 2, 4, 3, 8, 7, 6], @tree.traverse_post)
  end

  def test_remove_no_match
    @tree.insert(1)
    @tree.insert(2)
    @tree.insert(3)
    assert_nil(@tree.remove(4))
  end

  # print
  def test_traverse_pre
    @tree.insert(5)
    @tree.insert(4)
    @tree.insert(3)
    @tree.insert(8)
    @tree.insert(6)
    assert_equal([5, 4, 3, 8, 6], @tree.traverse_pre)
  end

  def test_traverse_post
    @tree.insert(5)
    @tree.insert(4)
    @tree.insert(3)
    @tree.insert(8)
    @tree.insert(6)
    assert_equal([3, 4, 6, 8, 5], @tree.traverse_post)
  end

  def test_traverse_order
    @tree.insert(5)
    @tree.insert(4)
    @tree.insert(3)
    @tree.insert(8)
    @tree.insert(6)
    assert_equal([3, 4, 5, 6, 8], @tree.traverse_order)
  end

  def test_max_normal
    #      5
    #    /  \
    #   4    6
    #  /
    # 3
    @tree.insert(5)
    @tree.insert(4)
    @tree.insert(3)
    @tree.insert(6)

    assert_equal(6, @tree.max.value)
  end

  def test_min_normal
    #      5
    #    /  \
    #   4    6
    #  /
    # 3
    @tree.insert(5)
    @tree.insert(4)
    @tree.insert(3)
    @tree.insert(6)

    assert_equal(3, @tree.min.value)
  end
end
