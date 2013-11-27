class Stack
  def initialize
    @stack = []
  end

  def length
    @stack.length
  end
  alias_method :size, :length

  def push element
    @stack << element
  end
  alias_method :<<, :push

  def pop
    @stack.pop
  end

  def empty?
    @stack.empty?
  end
end
