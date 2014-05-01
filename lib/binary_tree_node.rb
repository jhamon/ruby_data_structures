class ExcessChildError < StandardError; end
class UnknownChildTypeError < StandardError; end

class BinaryTreeNode
  # A binary tree node is a node with a value and
  # references to a left child, right child, and
  # parent nodes of the same class. No ordering
  # is required (that is, these nodes do not enforce
  # the BST property. )

  attr_accessor :value
  attr_reader :left_child, :right_child, :parent

  def initialize(options={})
    @value = options[:value]
  end

  def insert_left_child(child=BinaryTreeNode.new)
    raise UnknownChildTypeError if !child.is_a?(BinaryTreeNode)
    raise ExcessChildError if !@left_child.nil?
    child.parent = self
    @left_child = child
  end

  def insert_right_child(child=BinaryTreeNode.new)
    raise UnknownChildTypeError if !child.is_a?(BinaryTreeNode)
    raise ExcessChildError if !@right_child.nil?
    child.parent = self
    @right_child = child
  end

  protected
    def parent=(new_parent)
      @parent = new_parent
    end
end
