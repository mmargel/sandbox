# frozen_string_literal: true

# Standard Singly Linked List
class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def insert_head(item)
    raise(ArgumentError, 'item cannot be nil') if item.nil?
    new_node = Node.new(item)

    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      @head.next = new_node
      @head = new_node
    end

    item
  end

  def insert_tail(item)
    raise(ArgumentError, 'item cannot be nil') if item.nil?
    new_node = Node.new(item)

    if @tail.nil?
      @head = new_node
    else
      new_node.next = @tail
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
      new_head = @tail
      new_head = new_head.next while new_head.next != item
      @head = new_head
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
    target = @tail
    target = target.next while !target.nil? && target.value != value
    target
  end

  def delete(value)
    if @tail.value == value
      match = @tail
      @tail = @tail.next
    else
      pre_target = @tail
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
