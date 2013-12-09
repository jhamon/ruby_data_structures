require 'rspec'
require 'heap.rb'

def valid_max_heap?(arr)
  valid = []
  (arr.length/2..0).to_a.each_index do |i|
    if i.zero?
      valid << (arr[0] >= arr[1])
      valid << (arr[0] >= arr[2])
    end
    valid << (arr[i] >= arr[2*i])
    valid << (arr[i] >= arr[2*i+1])
  end
  valid.all? 
end

def valid_max_heap?(arr)
  valid = []
  (arr.length/2..0).to_a.each_index do |i|
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

  describe "#[]=" do
    it "can be assigned to like an" do
      expect(heap[3]=5).to eq(5)
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
      expect(valid_max_heap?(maxheap.heap)).to be_true
    end

    it "returns nil when called on an empty heap" do
      mh = MaxHeap.new
      expect(mh.extract_max).to be_nil
    end
  end
end
