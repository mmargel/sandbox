# frozen_string_literal: true

# Standard Singly Linked List
# @head = [*, -]--> [*, -]--> [*, -]--> = @tail
class DoublyLinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def insert_head(item)
    raise(ArgumentError, 'item cannot be nil') if item.nil?
    new_node = Node.new(item)

    if empty?
      @tail = new_node
    else
      @head.prev = new_node
      new_node.next = @head
    end
    @head = new_node

    item
  end

  def insert_tail(item)
    raise(ArgumentError, 'item cannot be nil') if item.nil?
    new_node = Node.new(item)

    if empty?
      @head = new_node
    else
      new_node.prev = @tail
      @tail.next = new_node
    end
    @tail = new_node

    item
  end

  def empty?
    @head == @tail && @head.nil?
  end

  def find(value)
    return nil if empty?
    if @head.value == value
      @head
    else
      target = @head
      target = target.next while !target.nil? && target.value != value
      target
    end
  end

  def remove(value)
    return nil if empty?
    if @head.value == value && @head == @tail
      match = @head
      @head = nil
      @tail = nil
    elsif @head.value == value
      match = @head
      @head = @head.next
      @head.prev = nil
    elsif @tail.value == value
      match = @tail
      @tail = @tail.prev
      @tail.next = nil
    else
      match = find(value)
      return nil unless match
      match.prev.next = match.next
      match.next.prev = match.prev
    end
    match.value
  end

  class Node
    attr_accessor :prev, :next, :value

    def initialize(value)
      @value = value
      @next = nil
      @prev = nil
    end
  end
end
