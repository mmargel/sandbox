# frozen_string_literal: true
require_relative "../../data_structures/linked_list"
require "test/unit"

class TestLinkedList < Test::Unit::TestCase
  def setup
    @list = LinkedList.new
  end

  # insert
  def test_insert_nil
    assert_raise(ArgumentError) { @list.insert(nil) }
  end

  def test_insert_non_nil
    assert_equal(2, @list.insert(2))
    assert_equal(4, @list.insert(4))
  end

  # remove
  def test_remove_empty
    assert_raise(ArgumentError) { @list.remove(nil) }
  end

  def test_remove_non_empty
    @list.insert(3)
    assert_equal(3, @list.remove)
  end

  def test_remove_multi
    @list.insert(1)
    @list.insert(2)
    @list.insert(3)
    assert_equal(3, @list.remove)
    assert_equal(2, @list.remove)
    assert_equal(1, @list.remove)
  end


  # peek
  def test_peek_empty
    assert_raise(ArgumentError) { @list.remove }
  end

  def test_peek_non_empty
    @list.insert(1)
    @list.insert(2)
    @list.insert(3)
    assert_equal(3, @list.peek)
    assert_equal(3, @list.peek)
  end

  # empty
  def test_empty_true
    assert(@list.empty?)
  end

  def test_empty_false
    @list.insert(3)
    assert(!@list.empty?)
  end

  def test_empty_dequeued
    @list.insert(3)
    @list.remove
    assert(@list.empty?)
  end

  # find
  def test_find_match
    @list.insert(1)
    @list.insert(2)
    @list.insert(3)
    assert_equal(2, @list.find(2).value)
  end

  def test_find_no_match
    @list.insert(1)
    @list.insert(2)
    @list.insert(3)
    assert_nil(@list.find(4))
  end

  # delete
  def test_delete_match
    @list.insert(1)
    @list.insert(2)
    @list.insert(3)
    assert_not_nil(@list.find(2))
    assert_equal(2, @list.delete(2).value)
    assert_nil(@list.find(2))
  end

  def test_delete_head
    @list.insert(1)
    @list.insert(2)
    @list.insert(3)
    assert_not_nil(@list.find(3))
    assert_equal(3, @list.delete(3).value)
    assert_nil(@list.find(3))
  end

  def test_delete_no_match
    @list.insert(1)
    @list.insert(2)
    @list.insert(3)
    assert_nil(@list.delete(4))
  end
end
