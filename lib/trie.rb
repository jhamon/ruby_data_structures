class Trie
  attr_reader :root, :size

  def initialize
    @size = 0
    @root = TrieNode.new("")
  end

  def self.from_array(array)
    trie = Trie.new
    array.each do |word|
      trie.insert(word)
    end

    trie
  end

  def insert(word)
    letters = word.split("")
    current_node = root

    letters.each_with_index do |letter, index|
      if current_node.has_child?(letter)
        current_node = current_node[letter]
      else
        @size += 1
        new_node             = TrieNode.new
        current_node[letter] = new_node
        current_node         = new_node
      end
    end

    current_node.value = word
  end

  def include?(word)
    letters = word.split("")
    current_node = root

    letters.each_with_index do |letter, index|
      if current_node.has_child?(letter)
        current_node = current_node[letter]
      else
        return false
      end
    end

    current_node.value == word ? true : false
  end

  def completions_for(word)
    letters = word.split("")
    current_node = root

    letters.each_with_index do |letter, index|
      if current_node.has_child?(letter)
        current_node = current_node[letter]
      else
        return [] # No completions
      end
    end

    # Collect leaves below the current_node
    completions_below_node(current_node).map(&:value)
  end

  def completions_below_node(node)
    if node.leaf?
      completions = [node]
    else
      completions = []

      # If the current node has a non-nil value, we need to include it whether
      # or not it has children. 
      completions << node if !node.value.nil?

      # We also need to explore all the child nodes
      node.child_nodes.each do |child|
        completions += completions_below_node(child)
      end
    end

    completions
  end
end

class TrieNode
  attr_accessor :value

  def initialize(value = nil)
    @children = {}
    @value = value
  end

  def []=(letter, node)
    raise "Invalid node" unless node.is_a?(TrieNode)
    children[letter] = node
    node
  end

  def has_child?(l)
    children.has_key? l
  end

  def [](letter)
    children[letter]
  end

  def leaf?
    children.count == 0 && !@value.nil?
  end

  def child_nodes
    children.sort.map { |pair| pair[1] }
  end

  def children
    @children
  end
end
