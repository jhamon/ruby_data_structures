require 'rspec'
require 'nodes.rb'

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

describe "LinkedListNode" do
  let(:sentinel) { SentinelNode.new }
  subject(:node) { LinkedListNode.new(5, sentinel) }

  it { should respond_to(:value) }
  it { should respond_to(:pointer) }
  it { should respond_to(:value=) }
  it { should respond_to(:pointer=) }

  it "should maintain a pointer to another node" do
    expect(node.pointer).to be_a(Node)
  end

  it "should not allow a nil pointer" do
    expect { node.pointer = nil }.to raise_error
  end
end

