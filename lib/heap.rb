class HeapBase
  attr_reader :heap

  def initialize(heap=[])
    raise ArgumentError unless heap.is_a?(Array)
    @heap = heap
  end

  def length
    @heap.length
  end

  def [](i)
    @heap[i]
  end

  def inspect
    @heap
  end

  def to_s
    inspect.to_s
  end

  private
    def parent_i(i)
      raise ArgumentError unless i.is_a?(Integer)
      return nil if i.zero?
      i/2
    end

    def left_i(i)
      raise ArgumentError unless i.is_a?(Integer)
      return 1 if i.zero?
      2*i 
    end

    def right_i(i)
      raise ArgumentError unless i.is_a?(Integer)
      return 2 if i.zero?
      2*i + 1
    end
end
