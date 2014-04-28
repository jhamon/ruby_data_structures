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

    it "overwrites when a key is already pressent" do
      hash["hello"] = "world"
      hash["hello"] = "dolly"
      expect(hash["hello"]).to eq("dolly")
    end
  end

  describe "#[]" do
    it "can fetch stored items using a key" do
      hash["hello"] = "world"
      hash["another"] = "value"
      expect(hash["hello"]).to eq("world")
    end

    it "works even aftr the hash's internal buckets array is resized" do
      hash[:one] = true
      hash[:two] = true
      hash[:three] = true
      hash[:four] = true
      hash[:five] = true
      hash[:six] = true
      expect(hash[:one]).to be_true
      expect(hash[:three]).to be_true
    end
  end

  describe "#has_key?" do
    it "returns true if the key is in the hashmap" do
      hash[:key] = :value
      expect(hash.has_key?(:key)).to eq(true)
    end

    it "returns false if the key is not in the hashmap" do
      expect(hash.has_key?(:key)).to eq(false)
    end

    it "works for keys with nil values" do
      hash[:key] = nil
      expect(hash.has_key?(:key)).to be_true
    end
  end

  describe "#length" do
    it "gives the number of key/value pairs in the hash" do
      expect(hash.length).to eq(0)
      hash[:hello] = :world
      expect(hash.length).to eq(1)
    end

    it "does not increment when a key is overwritten" do
      hash[:hello] = :world
      hash[:hello] = :again
      expect(hash.length).to eq(1)
    end
  end
end
