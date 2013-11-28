require 'rspec'
require 'stack.rb'

describe "Stack" do
  subject(:stack) { Stack.new }
  it { should respond_to (:pop) }
  it { should respond_to (:push) }
  it { should respond_to (:empty?) }
  
  context "an empty stack" do
    it "has size zero" do
      expect(stack.length).to eq(0)
      expect(stack.size).to eq(0)
    end

    it "returns nil when popped" do
      expect(stack.pop).to be_nil
    end

    it "knows that it is #empty?" do
      expect(stack.empty?).to be(true)
    end
  end

  context "a non-empty stack" do
    before(:each) do 
      stack << 3
      stack << 2
      stack << 1
    end

    it "has a length property" do
      expect(stack.length).to eq(3)
    end

    context "when popped" do
      it "decreases its length" do
        stack.pop
        expect(stack.length).to eq(2)
      end

      it "returns the last element pushed (FILO)" do
        expect(stack.pop).to eq(1)
      end
    end

    context "when pushed" do
      it { should respond_to(:<<) }
      
      it "should increase the stack length by one" do
        start_length = stack.length
        stack << 0
        expect(stack.length).to eq(start_length + 1)
      end
    end
  end

  context "when holding numerical values" do
    it "keeps track of the maximum value" do
      stack << 5
      stack << 4
      expect(stack.max).to be(5)
    end

    it "updates the max even when the current max is removed" do
      stack << 5
      stack << 4
      stack << 10
      expect(stack.max).to be(10)
      stack.pop
      expect(stack.max).to be(5)
      stack.pop
      expect(stack.max).to be(5)
      stack.pop
      expect(stack.max).to be_nil
    end
  end
end
