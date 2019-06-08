# frozen_string_literal: true
require_relative "../../data_structures/doubly_linked_list"
require "test/unit"

class TestDoublyLinkedList < Test::Unit::TestCase
  def setup
    @list = DoublyLinkedList.new
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
    @list.remove(3)
    assert(@list.empty?)
  end

  # find
  def test_find_match
    @list.insert_head(1)
    @list.insert_head(2)
    @list.insert_head(3)
    assert_equal(2, @list.find(2).value)
  end

  def test_find_no_match
    @list.insert_head(1)
    @list.insert_head(2)
    @list.insert_head(3)
    assert_nil(@list.find(4))
  end

  # remove
  def test_remove_match
    @list.insert_head(1)
    @list.insert_head(2)
    @list.insert_head(3)
    assert_not_nil(@list.find(2))
    assert_equal(2, @list.remove(2))
    assert_nil(@list.find(2))
  end

  def test_remove_no_match
    @list.insert_head(1)
    @list.insert_head(2)
    @list.insert_head(3)
    assert_nil(@list.remove(4))
  end

  def test_remove_head
    @list.insert_head(1)
    @list.insert_head(2)
    @list.insert_head(3)
    assert_not_nil(@list.find(3))
    assert_equal(3, @list.remove(3))
    assert_nil(@list.find(3))
  end

  def test_remove_tail
    @list.insert_head(1)
    @list.insert_head(2)
    @list.insert_head(3)
    assert_not_nil(@list.find(1))
    assert_equal(1, @list.remove(1))
    assert_nil(@list.find(1))
  end
end
