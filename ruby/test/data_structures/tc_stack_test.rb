# frozen_string_literal: true
require_relative "../../data_structures/stack"
require "test/unit"

class TestStack < Test::Unit::TestCase
  def setup
    @stack = Stack.new
  end

  # push
  def test_push_null
    assert_raise(ArgumentError) { @stack.push(nil) }
  end

  def test_push_none
    assert_raise(ArgumentError) { @stack.push }
  end

  def test_push_valid
    assert_equal(4, @stack.push(4))
  end

  # pop
  def test_pop_valid
    @stack.push(4)
    assert_equal(4, @stack.pop)
  end

  def test_pop_empty
    assert_raise(ArgumentError) { @stack.pop }
  end

  def test_pop_multi
    @stack.push(1)
    @stack.push(2)
    @stack.push(3)
    assert_equal(3, @stack.pop)
  end

  # empty?
  def test_empty_false
    @stack.push(4)
    assert(!@stack.empty?)
  end

  def test_empty_true
    assert(@stack.empty?)
  end

  def test_empty_popped
    @stack.push(1)
    @stack.push(2)
    @stack.pop
    @stack.pop
    assert(@stack.empty?)
  end

  # peek
  def test_peek_valid
    @stack.push(4)
    assert_equal(4, @stack.peek)
  end

  def test_peek_empty
    assert_raise(ArgumentError) { @stack.peek }
  end
end
