# frozen_string_literal: true
require_relative "../../data_structures/queue"
require "test/unit"

class TestQueue < Test::Unit::TestCase
  def setup
    @queue = Queue.new
  end

  # enqueue
  def test_enqueue_null
    assert_raise(ArgumentError) { @queue.enqueue(nil) }
  end

  def test_enqueue_none
    assert_raise(ArgumentError) { @queue.enqueue }
  end

  def test_enqueue_valid
    assert_equal(4, @queue.enqueue(4))
  end

  # dequeue
  def test_dequeue_valid
    @queue.enqueue(4)
    assert_equal(4, @queue.dequeue)
  end

  def test_dequeue_empty
    assert_raise(ArgumentError) { @queue.dequeue }
  end

  def test_dequeue_multi
    @queue.enqueue(1)
    @queue.enqueue(2)
    @queue.enqueue(3)
    assert_equal(3, @queue.dequeue)
  end

  # empty?
  def test_empty_false
    @queue.enqueue(4)
    assert(!@queue.empty?)
  end

  def test_empty_true
    assert(@queue.empty?)
  end

  def test_empty_dequeueped
    @queue.enqueue(1)
    @queue.enqueue(2)
    @queue.dequeue
    @queue.dequeue
    assert(@queue.empty?)
  end

  # peek
  def test_peek_valid
    @queue.enqueue(4)
    assert_equal(4, @queue.peek)
  end

  def test_peek_empty
    assert_raise(ArgumentError) { @queue.peek }
  end
end
