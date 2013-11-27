class Node
end

class SinglyLinkedNode < Node
  attr_reader :value, :pointer

  def initialize
    raise "Abstract base class called."
  end
end

class SentinelNode < SinglyLinkedNode
  def initialize
    @value = :sentinel
    @pointer = nil
  end
end

class LinkedListNode < SinglyLinkedNode
  attr_writer :value

  def initialize(value, parent_node)
    @value = value
    raise "Invalid node reference" unless parent_node.is_a?(Node)
    @pointer = parent_node
  end

  def pointer=(node)
    raise ArgumentError unless node.is_a?(Node)
    @pointer = node
  end
end

