require 'heap.rb'

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

