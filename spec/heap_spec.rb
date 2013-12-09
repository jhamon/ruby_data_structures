require 'rspec'
require 'heap.rb'
require 'min_heap.rb'
require 'max_heap.rb'

def valid_max_heap?(arr)
  valid = []
  (arr.length/2-1).downto(0).each do |i|
    if i.zero?
      valid << (arr[0] >= arr[1])
      valid << (arr[0] >= arr[2])
    end
    valid << (arr[i] >= arr[2*i])
    valid << (arr[i] >= arr[2*i+1])
  end
  valid.all? 
end

def valid_min_heap?(arr)
  valid = []
  (arr.length/2-1).downto(0).each do |i|
    if i.zero?
      valid << (arr[0] <= arr[1])
      valid << (arr[0] <= arr[2])
    end
    valid << (arr[i] <= arr[2*i])
    valid << (arr[i] <= arr[2*i+1])
  end
  valid.all? 
end

describe "HeapBase" do
  subject(:heap) { HeapBase.new([1,2,3,4,5,6,7]) }

  it "can be initialized empty" do
    expect { HeapBase.new }.not_to raise_error
  end

  describe "#left_i" do
    it "takes an index and returns the index of the left child" do
      expect(heap.send(:left_i, 4)).to eq(8)
    end

    it "gives the correct left_child index for position 0" do
      expect(heap.send(:left_i, 0)).to eq(1)
    end

    it "expects an integer index" do
      expect {heap.send(:left_i, 4.5)}.to raise_error
    end
  end

  describe "#right_i" do
    it "takes an index and returns the index of the right child" do
      expect(heap.send(:right_i, 4)).to eq(9)
    end

    it "gives the correct right_child index for position 0" do
      expect(heap.send(:right_i, 0)).to eq(2)
    end

    it "expects an integer index" do
      expect {heap.send(:right_i, 4.5)}.to raise_error
    end
  end

  describe "#parent_i" do
    it "takes an index and returns the index of the parent" do
      expect(heap.send(:parent_i, 10)).to eq(5)
    end

    it "expects an integer index" do
      expect {heap.send(:parent_i, 4.5)}.to raise_error
    end

    it "returns nil when called on the root element" do
      expect(heap.send(:parent_i, 0)).to be_nil
    end
  end

  describe "#[]" do
    it "can be indexed into like an Array" do
      expect(heap[3]).to be_a(Integer)
    end
  end

end

describe "MaxHeap" do
  subject(:maxheap) { MaxHeap.new([1,2,3,4,5,6,7,8,9,10]) }

  it "places the largest value at the root position" do
    expect(maxheap.heap[0]).to eq(10)
  end

  it "correctly max-heapify's an arbitrary array of integers" do
    expect(valid_max_heap?(maxheap.heap)).to be_true
  end

  describe "#delete_at" do
    it "returns the deleted element" do
      thing_at_index_five = maxheap[5]
      expect(maxheap.delete_at(5)).to eq(thing_at_index_five)
    end

    it "decreases the length of the array" do
      start_length = maxheap.length
      maxheap.delete_at(2)
      expect(maxheap.length).to eq(start_length - 1)
    end

    it "retains the max-heap property" do
      maxheap.delete_at(4)
      expect(valid_max_heap?(maxheap.heap)).to be_true
    end

    it "does nothing if passed an invalid index" do
      start_heap = maxheap.heap
      expect(maxheap.delete_at(1000)).to be_nil
      expect(maxheap.heap).to eq(start_heap)
    end
  end

  describe "#extract_max" do
    it "returns the root element" do
      expect(maxheap.extract_max).to eq(10)
    end

    it "decreases the length of the array" do
      start_length = maxheap.length
      maxheap.extract_max
      expect(maxheap.length).to eq(start_length - 1)
    end

    it "retains the max-heap property" do
      maxheap.extract_max
      p maxheap.heap
      expect(valid_max_heap?(maxheap.heap)).to be_true
    end

    it "returns nil when called on an empty heap" do
      mh = MaxHeap.new
      expect(mh.extract_max).to be_nil
    end
  end

  describe "#max" do
    it "gives the current max "do
      expect(maxheap.max).to eq(10)
    end

    it "gives nil when called on an empty max heap" do
      mh = MaxHeap.new
      expect(mh.max).to be_nil
    end
  end

  describe "<<" do
    it "increases the heap size" do
      original_length = maxheap.length
      maxheap << 100
      expect(maxheap.length).to eq(original_length + 1)
    end

    it "maintains the max-heap property" do
      maxheap << 100
      expect(valid_max_heap?(maxheap)).to be_true
      maxheap << 50
      expect(valid_max_heap?(maxheap)).to be_true
      maxheap << -50
      expect(valid_max_heap?(maxheap)).to be_true
    end
  end
end

describe "MinHeap" do
  subject(:minheap) { MinHeap.new [4,3,1,6,7,8,10,0,5] }

  it "places the smallest value at the root position" do
    expect(minheap[0]).to eq(minheap.heap.min)
  end

  it "is a valid min-heap" do
    expect(valid_min_heap?(minheap.heap)).to be_true
  end

  it "builds a min-heap from a random array of integers" do
    some_integers = Array.new(10) { rand(100) }
    minheap = MinHeap.new some_integers
    expect(valid_min_heap?(minheap.heap)).to be_true
  end

  it "works properly with negative numbers too" do
    some_integers = Array.new(10) { -1 * rand(100) }
    minheap = MinHeap.new some_integers
    expect(valid_min_heap?(minheap.heap)).to be_true
    expect(minheap.heap[0]).to eq(minheap.heap.min)
  end

  describe "#extract_min" do
    it "returns the smallest value in the heap" do
      min_item = minheap.heap.min
      expect(minheap.extract_min).to eq(min_item)
    end

    it "decreases the heap size by one" do
      start_length = minheap.length
      minheap.extract_min
      expect(minheap.length).to eq(start_length-1)
    end

    it "returns nil when called on an empty heap" do
      mh = MinHeap.new
      expect(mh.extract_min).to be_nil
    end

    it "preserves the min-heap property" do
      minheap.extract_min
      expect(valid_min_heap?(minheap)).to be_true
    end
  end

  describe "#delete_at" do
    it "returns the deleted element" do
      expect(minheap.delete_at(0)).to eq(0)
    end

    it "decreases the heap size by one" do
      start_length = minheap.length
      minheap.delete_at(3)
      expect(minheap.length).to eq(start_length-1)
    end

    it "maintains the min-heap property" do
      minheap.delete_at(2)
      expect(valid_min_heap?(minheap.heap)).to be_true
      minheap.delete_at(6)
      expect(valid_min_heap?(minheap.heap)).to be_true
    end
  end

  describe "#<<" do
    it "increases the heap size by one" do
      start_length = minheap.length
      minheap << 5
      expect(minheap.length).to eq(start_length+1)
    end
    
    it "maintains the heap property" do
      minheap << -1000
      expect(valid_min_heap?(minheap.heap)).to be_true
    end

    it "raises an error if a non-number is passed" do
      expect { minheap << "hello" }.to raise_error
    end
  end

  describe "#min" do
    it "returns the current min value" do
      expect(minheap.min).to eq(0)
    end

    it "does not modify the heap size" do
      start_length = minheap.length
      minheap.min
      expect(minheap.length).to eq(start_length)
    end

    it "returns nil on an empty heap" do
      mh = MinHeap.new
      expect(mh.min).to be_nil
    end
  end

end
