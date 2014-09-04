class Category < ActiveRecord::Base
  # Based on contributions from @bamnet on the 3.1 branch

  # Build a heirarchy of categories
  belongs_to :parent, class_name: 'Category'
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  has_many :documents
  belongs_to :group

  validates_presence_of :name

  # Find all categories serving as a root
  def self.roots
    categories = Category.where(parent_id: nil)
  end

  # Is this category a root?
  def is_root?
    parent_id.nil?
  end

  # Collect a list of parent categories
  # Each category the monkey stops as he climbs up the tree
  # Compliments of DHH http://github.com/rails/acts_as_tree
  def ancestors
    node, nodes = self, []
    nodes << node = node.parent while node.parent
    nodes
  end

  # Collect a list of children categories
  # Each category the monkey could stop by as he climbs down a tree
  # Compliments of http://github.com/funkensturm/acts_as_category
  def descendants
    node, nodes = self, []
    node.children.each { |child|
      # Check for circular dependenciess
      if !nodes.include?(child)
        nodes += [child]
        nodes += child.descendants
      end
    } unless node.children.empty?
    nodes
  end

  # Figure out a node's depth
  def depth
    ancestors.count
  end

  # The group of category who share a common parent
  def self_and_siblings
    parent ? parent.children : Category.roots
  end

  def self.featured
    # Show featured categories & their documents on the home page
    #  Select featured and public categories
    categories = Category.where(is_featured: true, is_private: false).order("random()")
    featured_docs = {}

    # select a categories documents that are private, order by upload date
    #  and choose only the most recent four to display
    categories.each do |cat|
      featured_docs[cat.id] = cat.documents.where(is_private: false).order("updated_at desc")[0..3]
    end

    featured_docs
  end

  # Define only the json attributes we need for the frontend
  def subcategories_json
    {id: id, name: name, depth: depth}
  end

end
