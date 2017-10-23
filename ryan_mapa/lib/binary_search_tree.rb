# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node.rb'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root
      insertify(value, @root)
    else
      @root = BSTNode.new(value)
    end
  end

  def find(value, tree_node = @root)
    return tree_node if tree_node.value == value

    if value > tree_node.value
      if tree_node.right
        find(value, tree_node.right)
      else
        return nil
      end
    else
      if tree_node.left
        find(value, tree_node.left)
      else
        return nil
      end
    end
  end

  def delete(value)
    ded = find(value, @root)
    return @root = nil if @root.value == value
    #no child case
    return ded.parent.right = nil unless ded.left || ded.right
    #there are children
    connectify(ded.parent, ded)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    if tree_node.right
      maximum(tree_node.right)
    else
      return tree_node
    end
  end

  def minimum(tree_node = @root)
    if tree_node.left
      maximum(tree_node.left)
    else
      return tree_node
    end
  end

  def depth(tree_node = @root)
    tree_node.left == nil && tree_node.right == nil ? 0 : inner(tree_node)
  end

  def inner(tree_node = @root)
    return 1 + inner(tree_node.left) if tree_node.left
    tree_node.right ? 1 + inner(tree_node.right) : 1
  end


  def is_balanced?(tree_node = @root)
    return true if tree_node.value == nil
    return true unless tree_node.left || tree_node.right

    left_side = tree_node.left ? depth(tree_node.left) : 0
    right_side  = tree_node.right ? depth(tree_node.right) : 0

    return false unless (left_side - right_side).abs <= 1
    return false unless is_balanced?(tree_node.left) if tree_node.left
    return false unless is_balanced?(tree_node.right) if tree_node.right
    true
  end

  def in_order_traversal(tree_node = @root, arr = [])
    if tree_node.left
      in_order_traversal(tree_node.left, arr)
    end
    arr.push(tree_node.value) if arr.last != tree_node.value
    if tree_node.right
      in_order_traversal(tree_node.right, arr)
    end
    arr
  end


  private

  def connectify(parent_node, ded)
    #two children
    if ded.left && ded.right
      two_children(parent_node, ded)
    else #one child
      one_child(parent_node, ded)
    end
  end

  def two_children(parent_node, ded)
    switch_node = maximum(ded.left)
    if switch_node.left
      switch_node.parent.right = switch_node.left
      switch_node.left.parent = switch_node.parent
    end
    switch_node.parent = parent_node
    switch_node.left = ded.left
    switch_node.right = ded.right
    if parent_node.right.value == ded.value
      parent_node.right = switch_node
    else
      parent_node.left = switch_node
    end
  end

  def one_child(parent_node, ded)
    if ded.left
      ded.left.parent = parent_node
      if parent_node.right.value == ded.value
        parent_node.right = ded.left
      else
        parent_node.left = ded.left
      end
    else
      ded.right.parent = parent_node
      if parent_node.right.value == ded.value
        parent_node.right = ded.right
      else
        parent_node.left = ded.right
      end
    end
  end

  def insertify(value, node)
    if value > node.value
      if node.right
        insertify(value, node.right)
      else
        new_node = BSTNode.new(value, node)
        node.right = new_node
      end
    else
      if node.left
        insertify(value, node.left)
      else
        new_node = BSTNode.new(value, node)
        node.left = new_node
      end
    end
  end

end
