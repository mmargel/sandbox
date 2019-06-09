# frozen_string_literal: true
require_relative "linked_list"

# Hash table for any value that can be converted to a string
class Set
  def initialize
    @buckets = []
  end

  def insert(value)
    key = hash(value)
    if @buckets[key].nil?
      @buckets[key] = PrintableLinkedList.new
    end
    @buckets[key].insert(value)
    value
  end

  def delete(value)
    key = hash(value)
    @buckets[key]&.remove(value)&.value
  end

  def to_array
    @buckets
      .reject(&:nil?)
      .reduce([]) do |acc, bucket|
        acc.push(*bucket.to_array)
      end
  end

  def [](value)
    get(value)
  end

  private

  def get(value)
    key = hash(value)
    @buckets[key]&.find(value)&.value
  end

  def hash(value)
    value.object_id % 4096
  end

  class PrintableLinkedList < LinkedList
    def to_array
      return [] if @head.nil?

      array = [@head.value]
      current = @head
      array << current.value while (current = current.next)

      array
    end
  end

  private_constant :PrintableLinkedList
end
