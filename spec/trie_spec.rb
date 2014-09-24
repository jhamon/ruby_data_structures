require 'rspec'
require 'trie.rb'

describe Trie do
  subject(:trie) { Trie.new }

  describe "Trie.from_array" do
    it "returns a trie instance" do
      trie = Trie.from_array(%w(heat help hello heart happy hungry helpful))
      expect(trie).to be_a(Trie)
    end

    it "the instance has all the words pre-inserted" do
      words = %w(heat help hello heart happy hungry helpful)
      trie  = Trie.from_array(words)

      words.each do |word|
        expect(trie.include?(word)).to be_true
      end
    end
  end

  describe "#size" do
    it "is initially zero" do
      expect(trie.size).to eq(0)
    end

    it "reflects the number of nodes in a trie" do
      trie.insert("hello")
      expect(trie.size).to eq(5)
      trie.insert("heat")
      expect(trie.size).to eq(7)
    end
  end

  describe "#insert" do
    it "adds nodes if they are not present" do
      trie.insert("hello")
      expect(trie.size).to eq(5)
    end

    it "adds does nothing if no additional nodes are needed" do
      trie.insert("help")
      expect(trie.size).to eq(4)
      trie.insert("he")
      expect(trie.size).to eq(4)
    end

    it "only adds missing nodes" do
      trie.insert("hell")
      expect(trie.size).to eq(4)
      trie.insert("hello")
      expect(trie.size).to eq(5)
    end
  end

  describe "#include?" do
    it "returns true if word is present" do
      trie.insert("chunky")
      expect(trie.include?("chunky")).to be_true
    end

    it "returns false if word not present" do
      trie.insert("chunky")
      expect(trie.include?("bacon")).to be_false
    end

    it "doesn't false positive on fragments" do
      trie.insert("help")
      expect(trie.include?("he")).to be_false
    end
  end

  describe "#completions_for" do
    before(:each) do 
      trie.insert("help")
      trie.insert("hello")
      trie.insert("heat")
      trie.insert("hat")
    end

    it "returns completions for a given fragmnet" do
      completions = trie.completions_for("he")
      expect(completions).to be_a(Array)
      expect(completions.length).to eq(3)
      expect(completions).to include("help")
      expect(completions).to include("hello")
      expect(completions).to include("heat")
    end

    it "returns completions in alphabetical order" do
      completions = trie.completions_for("he")
      expect(completions).to eq(["heat", "hello", "help"])
    end

    it "returns completions in alphabetical order" do
      words = %w(apple angst antipathy analgesic anteager anger angry anagram anthem)
      trie  = Trie.from_array(words)
      completions = trie.completions_for("an")
      expect(completions).to eq(words.sort.select { |w| w.start_with?("an") })
    end

    it "returns empty array if there are no completions" do
      expect(trie.completions_for("asdf")).to eq([])
    end

    it "finds completions that are not leaves" do
      words = %w(her he herself himself helpful help)
      trie = Trie.from_array(words)
      expect(trie.completions_for('h')).to include("he")
    end
  end
end