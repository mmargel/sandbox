# frozen_string_literal: true

# Standard Singly Linked List
# @head = [*, -]--> [*, -]--> [*, -]--> nil
class LinkedList
  def initialize
    @head = nil
  end

  def insert(item)
    raise(ArgumentError, 'item cannot be nil') if item.nil?
    new_node = Node.new(item)

    new_node.next = @head unless @head.nil?
    @head = new_node

    item
  end

  def remove
    raise(ArgumentError, 'list is empty') if empty?

    item = @head
    @head = @head.next
    item.value
  end

  def peek
    raise(ArgumentError, 'list is empty') if empty?

    @head.value
  end

  def empty?
    @head.nil?
  end

  def find(value)
    target = @head
    target = target.next while !target.nil? && target.value != value
    target
  end

  def delete(value)
    if @head.value == value
      match = @head
      @head = @head.next
    else
      pre_target = @head
      pre_target = pre_target.next while !pre_target.nil? && !pre_target.next.nil? && pre_target.next.value != value
      match = pre_target.next
      return nil if match.nil?
      pre_target.next = pre_target.next.next
    end
    match
  end

  class Node
    attr_accessor :next, :value

    def initialize(value)
      @value = value
      @next = nil
    end
  end
end
