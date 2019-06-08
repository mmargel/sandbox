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
    @list.remove(3)
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

  # remove
  def test_remove_match
    @list.insert(1)
    @list.insert(2)
    @list.insert(3)
    assert_not_nil(@list.find(2))
    assert_equal(2, @list.remove(2).value)
    assert_nil(@list.find(2))
  end

  def test_remove_head
    @list.insert(1)
    @list.insert(2)
    @list.insert(3)
    assert_not_nil(@list.find(3))
    assert_equal(3, @list.remove(3).value)
    assert_nil(@list.find(3))
  end

  def test_remove_no_match
    @list.insert(1)
    @list.insert(2)
    @list.insert(3)
    assert_nil(@list.remove(4))
  end
end
