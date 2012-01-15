class Category < ActiveRecord::Base
  has_many :documents
 
  # Build the hierarchy of categories
  belongs_to :parent, :class_name => 'Category'
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'
  
  # Let us quickly find the root categories
  scope :roots, where(:parent_id => nil)

  searchable do
    text :name
    text :description
  end

  # Test if this category is a root or not
  def is_root?
    parent_id.nil?
  end

  # Collect a list of parent categories.
  # Each category the monkey stops as he climbs
  # up the tree.
  # Compliments of DHH http://github.com/rails/acts_as_tree
  def ancestors
    node, nodes = self, []
    nodes << node = node.parent while node.parent
    nodes
  end

  # Collect recursive list of child category.
  # Every category the monkey could stop by as he
  # climbs down a tree.
  # Compliments of http://github.com/funkensturm/acts_as_category
  def descendants
    node, nodes = self, []
    node.children.each { |child|
      if !nodes.include?(child) #Try and stop any circular dependencies
        nodes += [child]
        nodes += child.descendants
      end
    } unless node.children.empty?
    nodes
  end

  # Figure out how deep in the tree
  # the current categpry is.  0 = root
  def depth
    ancestors.count
  end
  
  # The group of category who share a common parent.
  def self_and_siblings
    parent ? parent.children : Category.roots
  end

end
