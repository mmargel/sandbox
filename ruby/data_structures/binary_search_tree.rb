# frozen_string_literal: true

class BinarySearchTree
  def initialize
    @root = nil
  end

  def empty?
    @root.nil?
  end

  # Inserts the given value into a new leaf node
  def insert(value)
    raise(ArgumentError, 'value cannot be nil') if value.nil?

    if empty?
      @root = Node.new(value, nil)
    else
      target = @root
      while target
        last_node = target
        target = target.value >= value ? target.left : target.right
      end

      item = Node.new(value, last_node)
      if last_node.value >= value
        last_node.left = item
      else
        last_node.right = item
      end
    end
  end

  # Finds the first leaf node with the given value
  def find(value)
    raise(ArgumentError, 'value cannot be nil') if value.nil?

    if empty?
      nil
    else
      target = @root
      target = (target.value >= value ? target.left : target.right) while target&.value&.!=(value)
      target
    end
  end

  def max(node = @root)
    target = node
    target = target.right while target.right
    target
  end

  def min(node = @root)
    target = node
    target = target.left while target.left
    target
  end

  # Removes the given value from a tree
  # This node is replaced by the rightmost left node and the leftmost right node, in that order
  def remove(value)
    raise(ArgumentError, 'value cannot be nil') if value.nil?

    target = find(value)
    return nil unless target

    if target.left.nil?
      transplant(target, target.right)
    elsif target.right.nil?
      transplant(target, target.left)
    else
      # The MIN will necessarily not have a left child.
      # If it does, then it's not actually the min
      #
      # If the min is the immediate child of the target node, we can just
      # transplant it. If it's not, then we need to replace that node with
      # it's child (this effectively excises it from the tree until it gets
      # transplanted over the target node)
      new_node = min(target.right)
      if new_node.parent != target
        transplant(new_node, new_node.right)
        new_node.right = target.right
        new_node.right.parent = new_node
      end
      transplant(target, new_node)
      new_node.left = target.left
      new_node.left.parent = new_node
    end

    target
  end

  def transplant(old_node, new_node)
    if old_node.root?
      @root = new_node
    elsif old_node == old_node.parent.left
      old_node.parent.left = new_node
    else
      old_node.parent.right = new_node
    end
    new_node.parent = old_node.parent if new_node
  end

  def traverse_order(node = @root)
    left = node.left ? traverse_order(node.left) : []
    right = node.right ? traverse_order(node.right) : []
    [*left, node.value, *right]
  end

  def traverse_pre(node = @root)
    left = node.left ? traverse_pre(node.left) : []
    right = node.right ? traverse_pre(node.right) : []
    [node.value, *left, *right]
  end

  def traverse_post(node = @root)
    left = node.left ? traverse_post(node.left) : []
    right = node.right ? traverse_post(node.right) : []
    [*left, *right, node.value]
  end

  class Node
    attr_accessor :value, :parent, :left, :right

    def initialize(value, parent, left = nil, right = nil)
      @value = value
      @parent = parent
      @left = left
      @right = right
    end

    def leaf?
      left.nil? && right.nil?
    end

    def root?
      parent.nil?
    end
  end

  private_constant :Node
end
