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

  def self.define_insertion_methods(*child_positions)
    child_positions.each do |position|
      define_method("insert_#{position}_child") do |child|
        instance_var = "@#{position}_child"
        raise UnknownChildTypeError if !child.is_a?(BinaryTreeNode)
        raise ExcessChildError if !self.instance_variable_get(instance_var).nil?
        child.parent = self
        self.instance_variable_set(instance_var, child)
      end
    end
  end

  define_insertion_methods :left, :right

  def pop_left_child
    left_child = @left_child
    @left_child = nil
    left_child
  end

  def pop_right_child
    right_child = @right_child
    @right_child = nil
    right_child
  end

  protected
    def parent=(new_parent)
      @parent = new_parent
    end
end
