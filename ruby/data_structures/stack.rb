# frozen_string_literal: true

# Standard LIFO stack
# Technically, we can just wrap a ruby array in an API, but that's no fun.
class Stack
  def initialize
    # Because ruby arrays resize, we don't need to worry about manually expanding this as we add to it
    @contents = []
    @head = -1
  end

  # Pushes a non-nil item into the stack
  # Raises an ArgumentError if the item is nil.
  # Returns the added item
  def push(item)
    raise(ArgumentError, "item cannot be nil") if item.nil?

    @head += 1
    @contents[@head] = item
  end

  # Returns true if the stack is empty
  # It's empty when the head is at the start
  def empty?
    @head == -1
  end

  # shows the top element in the stack
  # If it's nil, this throws an ArgumentError
  def peek
    raise(ArgumentError, "stack is empty") if empty?

    @contents[@head]
  end

  # removes the top element in the stack
  # If it's nil, this throws an ArgumentError
  def pop
    raise(ArgumentError, "stack is empty") if empty?
    @head -= 1
    @contents[@head + 1]
  end
end
