# frozen_string_literal: true
require_relative "../../data_structures/linked_list"
require "test/unit"

class TestLinkedList < Test::Unit::TestCase
  def setup
    @list = LinkedList.new
  end

  # insert_head
  def test_insert_head_nil
    assert_raise(ArgumentError) { @list.insert_head(nil) }
  end

  def test_insert_head_non_nil
    assert_equal(2, @list.insert_head(2))
    assert_equal(4, @list.insert_head(4))
  end

  # insert_tail
  def test_insert_tail_nil
    assert_raise(ArgumentError) { @list.insert_tail(nil) }
  end

  def test_insert_tail_non_nil
    assert_equal(2, @list.insert_tail(2))
    assert_equal(4, @list.insert_tail(4))
  end

  # remove_head
  def test_remove_head_empty
    assert_raise(ArgumentError) { @list.remove_head(nil) }
  end

  def test_remove_head_non_empty
    @list.insert_head(3)
    assert_equal(3, @list.remove_head)
  end

  def test_remove_head_multi
    @list.insert_head(1)
    @list.insert_head(2)
    @list.insert_head(3)
    assert_equal(3, @list.remove_head)
    assert_equal(2, @list.remove_head)
    assert_equal(1, @list.remove_head)
  end

  # remove_tail
  def test_remove_tail_empty
    assert_raise(ArgumentError) { @list.remove_tail(nil) }
  end

  def test_remove_tail_non_empty
    @list.insert_tail(3)
    assert_equal(3, @list.remove_tail)
  end

  def test_remove_tail_multi
    @list.insert_tail(1)
    @list.insert_tail(2)
    @list.insert_tail(3)
    assert_equal(3, @list.remove_tail)
    assert_equal(2, @list.remove_tail)
    assert_equal(1, @list.remove_tail)
  end

  # head/tail mixed operations
  def test_add_head_remove_tail
    @list.insert_head(1)
    @list.insert_head(2)
    @list.insert_head(3)
    assert_equal(1, @list.remove_tail)
    assert_equal(2, @list.remove_tail)
    assert_equal(3, @list.remove_tail)
  end

  def test_add_tail_remove_head
    @list.insert_tail(1)
    @list.insert_tail(2)
    @list.insert_tail(3)
    assert_equal(1, @list.remove_head)
    assert_equal(2, @list.remove_head)
    assert_equal(3, @list.remove_head)
  end

  # peek_head
  def test_peek_head_empty
    assert_raise(ArgumentError) { @list.remove_head }
  end

  def test_peek_head_non_empty
    @list.insert_head(1)
    @list.insert_head(2)
    @list.insert_head(3)
    assert_equal(3, @list.peek_head)
    assert_equal(3, @list.peek_head)
  end

  # peek_tail
  def test_peek_tail_empty
    assert_raise(ArgumentError) { @list.peek_tail }
  end

  def test_peek_tail_non_empty
    @list.insert_tail(1)
    @list.insert_tail(2)
    @list.insert_tail(3)
    assert_equal(3, @list.peek_tail)
    assert_equal(3, @list.peek_tail)
  end

  # empty
  def test_empty_true
    assert(@list.empty?)
  end

  def test_empty_false
    @list.insert_head(3)
    assert(!@list.empty?)
  end

  def test_empty_dequeued
    @list.insert_head(3)
    @list.remove_tail
    assert(@list.empty?)
  end
end
