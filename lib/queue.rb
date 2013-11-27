class SimpleQueue
  def initialize
    @queue = []
  end

  def push item
    @queue << item
  end
  alias_method :<<, :push

  def pop
    @queue.shift
  end

  def empty?
    @queue.empty?
  end

  def length
    @queue.length
  end
  alias_method :size, :length

end
