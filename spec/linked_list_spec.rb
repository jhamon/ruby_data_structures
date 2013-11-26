require 'rspec'
require 'linked_list.rb'

describe "Sentinal nodes" do
  subject (:sentinel) { SentinelNode.new }

  it "should be a kind of Node" do
    expect(sentinel).to be_a(Node)
  end

  it "should not have a pointer to any other nodes" do
    expect(sentinel.pointer).to be_nil
  end

  it "should not store value" do
    expect(sentinel.value).to eq(:sentinel)
  end

  it "should not allow reassigment of its pointer" do
    expect(sentinel).not_to respond_to(:pointer=)
  end
end

describe "RegularNode" do
  let(:sentinel) { SentinelNode.new }
  subject(:node) { RegularNode.new(5, sentinel) }

  it { should respond_to(:value) }
  it { should respond_to(:pointer) }
  it { should respond_to(:value=) }
  it { should respond_to(:pointer=) }
end


describe "Linked lists" do
  subject(:linked_list) { LinkedList.new }

  it { should respond_to(:[]) }
  it { should respond_to(:[]=) }
  it { should respond_to(:<<) }
  it { should respond_to(:push) }
  it { should respond_to(:pop) }
  it { should respond_to(:root) }

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
  end
end
