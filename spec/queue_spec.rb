require 'rspec'
require 'queue.rb'

describe "Queue" do
  subject(:queue) { SimpleQueue.new }
  
  it { should respond_to :push }
  it { should respond_to :pop }

  context "when empty" do
    it "should be empty" do
      expect(queue.empty?).to be(true)
    end

    it "should have length/size zero" do
      expect(queue.length).to eq(0)
      expect(queue.size).to eq(0)
    end

    it "should return nil when popped" do
      expect(queue.pop).to be_nil
    end
  end

  context "when not empty" do
    before(:each) do 
      queue << :yo
      queue << :dawg
      queue << :i
      queue << :heard
      queue << :you
      queue << :like
      queue << :tests
    end

    it "popping should return the first element pushed (FIFO)" do
      expect(queue.pop).to eq(:yo)
    end

    it "should have a correct length/size" do
      expect(queue.length).to eq(7)
      expect(queue.size).to eq(7)
    end

    it "popping should remove the element from the queue" do
      queue.pop
      expect(queue.length).to eq(6)
      expect(queue.pop).to eq(:dawg)
    end
  end
end
