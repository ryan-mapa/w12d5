require_relative 'binary_search_tree.rb'

def kth_largest(tree_node, k)
  in_order_traversal(tree_node)[-k]
end
