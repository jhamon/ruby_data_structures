class ExcessChildError < StandardError; end
class UnknownChildTypeError < StandardError; end

class TreeNode
  # TreeNode is an abstract class that should not be instantiated 
  # directly.  Subclasses can accomodate an arbitrary number of
  # child nodes by declaring an array of child names in the 
  # @@child_positions before calling the define_method macros.

  attr_accessor :value
  attr_reader :parent

  def initialize(options={})
    @value = options[:value]
    raise "Abstract base class called" if self.class == TreeNode
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

  def self.define_pop_methods(*child_positions)
    child_positions.each do |position| 
      define_method("pop_#{position}_child") do
        instance_var = "@#{position}_child"
        stored_child = self.instance_variable_get(instance_var)
        self.instance_variable_set(instance_var, nil)
        stored_child
      end
    end
  end

  def self.define_attr_readers(*child_positions)
    child_positions.each do |position|
      instance_var = "@#{position}_child"
      define_method("#{position}_child") do 
        self.instance_variable_get(instance_var)
      end
    end
  end

  protected
    def parent=(new_parent)
      @parent = new_parent
    end
end


class BinaryTreeNode < TreeNode
  # A binary tree node is a node with a value and
  # references to a left child, right child, and
  # parent nodes of the same class. No ordering
  # is required (that is, these nodes do not enforce
  # the BST property. )

  @@child_positions = [:left, :right]

  define_insertion_methods *@@child_positions
  define_pop_methods *@@child_positions
  define_attr_readers *@@child_positions
end