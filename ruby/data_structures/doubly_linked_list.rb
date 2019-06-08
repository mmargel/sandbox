# frozen_string_literal: true

# Standard Singly Linked List
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
      new_node.prev = @head
      @head.next = new_node
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
      new_node.next = @tail
      @tail.prev = new_node
    end
    @tail = new_node

    item
  end

  def remove_head
    raise(ArgumentError, 'list is empty') if empty?

    item = @head

    if @head == @tail
      @head = nil
      @tail = nil
    else
      @head = @head.prev
      @head.next = nil
    end
    item.value
  end

  def remove_tail
    raise(ArgumentError, 'list is empty') if empty?

    item = @tail
    if @head == @tail
      @head = nil
      @tail = nil
    else
      @tail = @tail.next
      @tail.prev = nil
    end

    item.value
  end

  def peek_head
    raise(ArgumentError, 'list is empty') if empty?

    @head.value
  end

  def peek_tail
    raise(ArgumentError, 'list is empty') if empty?

    @tail.value
  end

  def empty?
    @head == @tail && @head.nil?
  end

  def find(value)
    return nil if empty?
    if @tail.value == value
      @tail
    else
      target = @tail
      target = target.next while !target.nil? && target.value != value
      target
    end
  end

  def delete(value)
    return nil if empty?
    if @head.value == value
      match = @head
      @head = @head.prev
      @head.next = nil
      match
    elsif @tail.value == value
      match = @tail
      @tail = @tail.next
      @tail.prev = nil
      match
    else
      target = find(value)
      return nil unless target

      target.prev.next = target.next
      target.next.prev = target.prev
      target
    end
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
