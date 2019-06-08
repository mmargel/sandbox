# frozen_string_literal: true

# Standard FIFO queue
# Technically, we can just wrap a ruby array in an API, but that's no fun.
class Queue
  def initialize
    # Because ruby arrays resize, we don't need to worry about manually expanding this as we add to it
    @contents = []
    @head = -1
    @tail = -1
  end

  # Enqueues a non-nil item into the queue
  # Raises an ArgumentError if the item is nil.
  # Returns the added item
  def enqueue(item)
    raise(ArgumentError, "item cannot be nil") if item.nil?
    @head += 1
    @contents[@head] = item
  end

  # Returns true if the queue is empty
  # It's empty when the head is at the start
  def empty?
    @head == @tail
  end

  # shows the tail element in the queue
  # If it's nil, this throws an ArgumentError
  def peek
    raise(ArgumentError, "queue is empty") if empty?
    @contents[@tail]
  end

  # removes the top element in the queue
  # If it's nil, this throws an ArgumentError
  def dequeue
    raise(ArgumentError, "queue is empty") if empty?
    @tail += 1
    @contents[@tail]
  end
end
