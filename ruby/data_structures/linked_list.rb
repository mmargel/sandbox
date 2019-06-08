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
      @head.next_node = new_node
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
      new_node.next_node = @tail
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
      new_head = new_head.next_node while new_head.next_node != item
      @head = new_head
      @head.next_node = nil
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
      @tail = @tail.next_node
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

  class Node
    attr_accessor :next_node, :value

    def initialize(value)
      @value = value
      @next_node = nil
    end
  end
end
