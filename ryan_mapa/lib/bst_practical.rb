require_relative 'binary_search_tree.rb'

def kth_largest(tree_node, k)
  tree = BinarySearchTree.new
  val = tree.in_order_traversal(tree_node)[-k]
  tree.find(val, tree_node)
end
