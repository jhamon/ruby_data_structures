class Trie
  attr_reader :root, :size

  def initialize
    @size = 0
    @root = TrieNode.new("")
  end

  def self.from_array(word_array)
    trie = Trie.new
    word_array.each do |word|
      trie.insert(word)
    end

    trie
  end

  def insert(word)
    letters = word.split("")
    current_node = root

    letters.each do |letter|
      if current_node.has_child?(letter)
        current_node = current_node[letter]
      else
        @size += 1
        current_node[letter] = TrieNode.new
        current_node         = current_node[letter]
      end
    end

    current_node.value = word
  end

  def include?(word)
    current_node = root

    word.split("").each do |letter|
      if current_node.has_child?(letter)
        current_node = current_node[letter]
      else
        return false
      end
    end

    current_node.value == word ? true : false
  end

  def completions_for(word)
    current_node = root

    word.split("").each do |letter|
      if current_node.has_child?(letter)
        current_node = current_node[letter]
      else
        return [] # No completions
      end
    end

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
  attr_reader :children

  def initialize(value = nil)
    @children = {}
    @value = value
  end

  def []=(letter, node)
    raise "Invalid node" unless node.is_a?(TrieNode)
    children[letter] = node
    node
  end

  def [](letter)
    children[letter]
  end

  def has_child?(letter)
    children.has_key?(letter)
  end

  def leaf?
    children.count == 0
  end

  def child_nodes
    children.sort.map { |pair| pair[1] }
  end
end
