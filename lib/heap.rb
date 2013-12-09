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

class MaxHeap < HeapBase
  def initialize(heap=[])
    super(heap)
    build_max_heap
  end

  def delete_at(i)
    return nil if i > (length - 1)
    deleted = self[i]
    @heap[i] = @heap.pop
    max_heapify(i)
    deleted
  end

  def extract_max
    delete_at(0)
  end

  def max
    self[0]
  end

  def <<(value)
    @heap << value
    up_heap(length-1)
    value
  end

  private
    def up_heap(i)
      return if i == 0
      p = parent_i(i)
      if @heap[i] > @heap[p]
        @heap[p], @heap[i] = @heap[i], @heap[p]
        up_heap(p)
      end
    end

    def build_max_heap
      heap_size = @heap.length
      (heap_size/2-1).downto(0).each do |i| 
        max_heapify(i) 
      end
    end

    def max_heapify(i)
      l = left_i(i)
      r = right_i(i)

      largest = find_largest(i, l, r)

      if largest != i
        @heap[i], @heap[largest] = @heap[largest], @heap[i]
        max_heapify(largest)
      end
    end

    def find_largest(i, l, r)
      if l < @heap.length && @heap[l] > @heap[i]
        largest = l
      else 
        largest = i
      end

      if r < @heap.length && @heap[r] > @heap[largest]
        largest = r
      end
      largest
    end
end

class MinHeap < HeapBase
  def initialize(heap=[])
    super(heap)
    build_min_heap
  end

  def delete_at(i)
  end

  def extract_min
  end

  private
    def build_min_heap
      (length/2).downto(0).each do |i|
        min_heapify(i)
      end
    end

    def min_heapify(i)
      l = left_i(i)
      r = right_i(i)

      smallest = find_smallest(i, l, r)

      if smallest != i
        @heap[i], @heap[smallest] = @heap[smallest], @heap[i]
        min_heapify(smallest)
      end
    end

    def find_smallest(i, l, r)
      if l < @heap.length && @heap[l] < @heap[i]
        smallest = l
      elsif r < @heap.length && @heap[r] < @heap[i]
        smallest = r
      else
        smallest = i
      end
      smallest
    end
end
