require 'nodes.rb'

class LinkedList
  attr_reader :length

  def initialize
    @head = SentinelNode.new
    @length = 0
  end

  def <<(value)
    @head = LinkedListNode.new(value, @head)
    @length += 1
    self
  end
  alias_method :push, :<<

  def pop
    old_node, @head = @head, @head.pointer
    @length -= 1
    old_node.value
  end

  def insert(index, value)
    node = find_node_by_index(index)
    if !!node
      new_node = LinkedListNode.new(value, node.pointer)
      node.pointer = new_node
      @length += 1
    end
    self
  end

  def [](index)
    node = find_node_by_index(index)
    !!node ? node.value : nil
  end

  def []=(index, value)
    node = find_node_by_index(index)
    node.value = value if !!node
    !!node ? self : nil
  end

  def to_a
    values = []
    node = @head
    @length.times do 
      values << node.value
      node = node.pointer
    end
    values.reverse
  end

  def to_s
    values = to_a
    values.to_s 
  end

  private
    def find_node_by_index(n)
      return nil if n < 0 || n >= @length

      node = @head
      n.times do 
        node = node.pointer
      end

      node
    end
end

