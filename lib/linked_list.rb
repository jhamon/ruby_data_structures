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
    return nil if empty?
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

  def delete(index)
    return nil unless check_valid_index(index)
    if index == 0
      deleted_value = @head.value
      @head = @head.pointer
    else
      node = find_node_by_index(index-1)
      deleted_value = node.pointer.value
      node.pointer = node.pointer.pointer
    end

    @length -= 1
    deleted_value
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

  def empty?
    @head.is_a?(SentinelNode)
  end

  private

    def check_valid_index(n)
      return false if n < 0 || n >= @length
      return true
    end

    def find_node_by_index(n)
      return nil unless check_valid_index(n)

      node = @head
      n.times do 
        node = node.pointer
      end

      node
    end
end

