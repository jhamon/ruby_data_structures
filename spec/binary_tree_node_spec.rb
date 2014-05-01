require 'rspec'
require 'binary_tree_node.rb'


describe BinaryTreeNode do
  subject(:btnode) { BinaryTreeNode.new }

  describe "#value" do
    it "should have expose a value property" do
      expect(btnode).to respond_to(:value)
    end

    it "should have a default value of nil" do
      expect(btnode.value).to be_nil
    end
  end

  describe "#value=" do
    it "should allow value to be set at any time" do
      btnode.value = 42 
      expect(btnode.value).to equal(42)
    end
  end

  it "should accept a hash of configuration arguments" do
    options = { :value => 10 }
    expect { BinaryTreeNode.new( options ) }.not_to raise_error
    node = BinaryTreeNode.new(options)
    expect(node.value).to equal(10)
  end

  it "should use default values if no options hash is given" do
    expect(btnode.value).to be_nil
  end

  describe "#insert_left_child" do
    it "should raise an error if a BinaryTreeNode instance not recieved" do
      expect { btnode.insert_left_child(:not_a => :btnode) }.to raise_error(UnknownChildTypeError)
    end

    it "should return the node if it was successfully inserted" do
      child = BinaryTreeNode.new(:value => 100)
      expect(btnode.insert_left_child(child)).to equal(child)
    end

    it "should raise an error if there is already a left_child" do
      child1 = BinaryTreeNode.new
      child2 = BinaryTreeNode.new
      btnode.insert_left_child(child1)
      expect { btnode.insert_left_child(child2) }.to raise_error(ExcessChildError)
    end

    it "should store the added child on the left_child property" do
      child1 = BinaryTreeNode.new(:value => :awesome)
      btnode.insert_left_child(child1)
      expect(btnode.left_child.value).to equal(:awesome)
    end
  end


  describe "#left_child" do
    it "should respond to :left_child" do
      expect(btnode).to respond_to(:left_child)
    end

    context "if there is no left child" do
      it "should return nil" do
        expect(btnode.left_child).to be_nil
      end
    end

    context "if there is a left child" do
      it "should return another binary tree node" do
        child1 = BinaryTreeNode.new(:value => :awesome)
        btnode.insert_left_child(child1)
        expect(btnode.left_child).to be_a(BinaryTreeNode)
      end
    end
  end

  describe "#insert_right_child" do
    it "expects a BinaryTreeNode as argument" do
      not_a_btnode = { :value => :not_a_btnode } 
      expect { btnode.insert_right_child(not_a_btnode) }.to raise_error(UnknownChildTypeError)
    end

    it "should error if there is already a right_child defined" do
      child = BinaryTreeNode.new
      child2 = BinaryTreeNode.new
      btnode.insert_right_child(child)
      expect { btnode.insert_right_child(child2) }.to raise_error(ExcessChildError)
    end
  end

  describe "#right_child" do
    it "should return nil by default" do
      expect(btnode.right_child).to be_nil
    end

    it "should hold reference to the right child after one is inserted" do
      child = BinaryTreeNode.new
      btnode.insert_right_child(child)
      expect(btnode.right_child).to equal(child)
    end
  end

  describe "#insert_above"
  describe "#parent" do
    it "should respond to :parent" do
      expect(btnode).to respond_to(:parent)
    end

    it "should be nil by default" do
      expect(btnode.parent).to be_nil
    end

    it "should be set when inserting a node as a left_child" do
      child = BinaryTreeNode.new
      btnode.insert_left_child(child)
      expect(child.parent).to equal(btnode)
    end

    it "should be set when inserting a node as a right_child" do
      child = BinaryTreeNode.new
      btnode.insert_right_child(child)
      expect(child.parent).to equal(btnode)
    end

    it "should not be publicly changeable" do
      expect(btnode).not_to respond_to(:parent=)
    end
  end

  describe "#pop_right_child" do
    before(:each) { btnode.insert_right_child( BinaryTreeNode.new ) }

    it "should return the right child" do
      right = btnode.right_child
      expect(btnode.pop_right_child).to equal(right)
    end

    it "should set the right child to nil" do
      btnode.pop_right_child
      expect(btnode.right_child).to be_nil
    end

    it "should return nil if there is no right child" do
      btnode.pop_right_child
      expect(btnode.pop_right_child).to be_nil
    end
  end

  describe "#pop_left_child" do
    before(:each) { btnode.insert_left_child( BinaryTreeNode.new ) }

    it "should return the left child" do
      left = btnode.left_child
      expect(btnode.pop_left_child).to equal(left)
    end

    it "should set the left child to nil" do
      btnode.pop_left_child
      expect(btnode.left_child).to be_nil
    end

    it "should return nil if there is no left child" do
      btnode.pop_left_child
      expect(btnode.pop_left_child).to be_nil
    end
  end
end

