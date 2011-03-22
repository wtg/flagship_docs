module CategoriesHelper

  # Generate a DFS tree of categories
  def dfs_tree(roots = Category.roots)
    nodes = []
    roots.each do |node|
      nodes += [node]
      nodes += node.descendants unless node.descendants.empty?
    end
    nodes
  end

end
