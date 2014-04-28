require 'rspec'
require 'hashmap.rb'

describe "HashMap" do
  subject(:hash) { HashMap.new }

  describe "#[]=" do
    it "can store a reference associated with a key" do
      expect { hash["hello"]="world" }.not_to raise_error
    end

    it "returns the stored item" do
      store_me = "world"
      expect(hash["hello"] = store_me ).to eq(store_me)
    end
  end

  describe "#[]" do
    it "can fetch stored items using a key" do
      hash["hello"] = "world"
      expect(hash["hello"]).to eq("world")
    end
  end

  describe "#has_key?"
  describe "#length"
end
