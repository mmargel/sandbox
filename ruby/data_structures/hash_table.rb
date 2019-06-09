# frozen_string_literal: true
require_relative "linked_list"

# Hash table for any value that can be converted to a string
class HashTable
  def initialize
    @buckets = []
  end

  def delete(key)
    raise(ArgumentError, "item cannot be nil") if key.nil?
    raise(ArgumentError, "item not in hash") unless self[key]

    hashed_key = hash(key)
    @buckets[hashed_key]&.remove(key)
  end

  def [](key)
    raise(ArgumentError, "item cannot be nil") if key.nil?

    hashed_key = hash(key)
    @buckets[hashed_key]&.find(key)
  end

  def []=(key, value)
    raise(ArgumentError, "item cannot be nil") if key.nil?

    hashed_key = hash(key)
    if @buckets[hashed_key].nil?
      @buckets[hashed_key] = KeyedLinkedList.new
    end
    @buckets[hashed_key].insert(key, value)
    value
  end

  private

  def hash(key)
    key.object_id % 4096
  end

  class KeyedLinkedList < LinkedList
    def initialize
      @head = nil
    end

    def insert(key, value)
      new_node = Node.new(key, value)
      new_node.next = @head unless @head.nil?
      @head = new_node

      value
    end

    def empty?
      @head.nil?
    end

    def find(key)
      target = @head
      target = target.next while !target.nil? && target.key != key
      target.value
    end

    def remove(key)
      if @head.key == key
        match = @head
        @head = @head.next
      else
        pre_target = @head
        pre_target = pre_target.next while !pre_target.nil? && !pre_target.next.nil? && pre_target.next.key != key
        match = pre_target.next
        return nil if match.nil?
        pre_target.next = pre_target.next.next
      end
      match.value
    end

    class Node
      attr_accessor :next, :value
      attr_reader :key

      def initialize(key, value)
        @value = value
        @key = key
        @next = nil
      end
    end
  end

  private_constant :KeyedLinkedList
end
