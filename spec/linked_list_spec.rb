require 'rspec'
require 'linked_list.rb'

describe "Linked lists" do
  subject(:linked_list) { LinkedList.new }

  it { should respond_to(:[]) }
  it { should respond_to(:[]=) }
  it { should respond_to(:<<) }
  it { should respond_to(:push) }
  it { should respond_to(:pop) }

  it "should begin with length zero" do
    expect(linked_list.length).to eq(0)
  end

  context "after adding some elements to the Linked List" do

    before(:each) do
      linked_list << 5
      linked_list << 4
      linked_list << :hello
      linked_list << :world
    end
  
    describe "#push" do
      it "pushing should increase the list length" do
        expect(linked_list.length).to eq(4)
      end

      it "pushing should add elements to the end of the linked list" do
        expect(linked_list.to_s).to eq("[5, 4, :hello, :world]")
      end
    end

    describe "#pop" do
      it "decreases the list length" do
        linked_list.pop
        expect(linked_list.length).to eq(3)
      end

      it "returns the last element" do
        expect(linked_list.pop).to eq(:world)
      end
    end

    describe "indexing into linked list with #[]" do
      it "is zero indexed" do
        expect(linked_list[0]).to eq(5)
        expect(linked_list[1]).to eq(4)
      end

      it "returns nil if you ask for an invalid index" do
        expect(linked_list[10]).to be_nil
      end
    end

    describe "setting values with #[]=" do
      it "sets the node value at that index position" do
        linked_list[2] = :another_value
        expect(linked_list[2]).to eq(:another_value)
      end

      it "does not allow you to set values outside the current list size" do
        expect(linked_list[10]=:out_of_bounds).to be_nil
        expect(linked_list.length).to eq(4) 
      end
    end

    describe "inserting values with #insert(index, value)" do
      it { should respond_to(:insert) }

      it "adds a new node to the linked list" do
        linked_list.insert(2,:another_value)
        expect(linked_list.length).to eq(5)
      end

      it "adds a new value at the index position specified" do
        linked_list.insert(2, :another_value)
        expect(linked_list[3]).to eq(:another_value)
      end
    end
  end
end
