require 'heap.rb'

class MinHeap < HeapBase
  def initialize(heap=[])
    super(heap)
    build_min_heap
  end

  def delete_at(i)
    deleted = @heap[i]
    @heap[i] = @heap.pop
    min_heapify(i)
    deleted
  end

  def extract_min
    delete_at(0)
  end

  def <<(value)
    @heap << value
    up_heap(length-1)
  end

  def min
    @heap[0]
  end

  private
    def up_heap(i)
      return true if i.zero?
      p = parent_i(i)
      if @heap[p] > @heap[i]
        @heap[p], @heap[i] = @heap[i], @heap[p]
        up_heap(p)
      end
    end

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
      smallest = i
      if l < @heap.length && @heap[l] < @heap[smallest]
        smallest = l
      end
      
      if r < @heap.length && @heap[r] < @heap[smallest]
        smallest = r
      end
      smallest
    end
end
