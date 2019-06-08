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
      new_node.prev_node = @head
      @head.next_node = new_node
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
      new_node.next_node = @tail
      @tail.prev_node = new_node
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
      @head = @head.prev_node
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
      @tail.prev_node = nil
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
    attr_accessor :prev_node, :next_node, :value

    def initialize(value)
      @value = value
      @next_node = nil
      @prev_node = nil
    end
  end
end
