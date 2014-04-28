class HashMap
  attr_reader :length, :buckets

  DEFAULT_BUCKETS = 5
  LOAD_FACTOR = 0.9

  def initialize
    @length = 0
    @buckets = Array.new(DEFAULT_BUCKETS) { [] }
  end

  def each(&blk)
    @buckets.each do |bucket|
      bucket.each do |key, value|
        blk.call(key, value)
      end
    end
  end

  def []=(key, value)
    if has_key?(key)
      replace(key, value)
    else
      resize_buckets if @length > LOAD_FACTOR * @buckets.length
      @length += 1
      insert(key, value)
    end
  end

  def [](key)
    bucket = @buckets[index_of(key)]
    bucket.each do |item_key, item_value|
      return item_value if item_key == key
    end
    nil
  end

  def keys
    @buckets.flatten.map { |k, v| k }
  end

  def has_key?(key)
    keys.include?(key)
  end

  private
    def index_of(key, buckets=@buckets)
      key.hash % buckets.length
    end

    def bucket_for(key, buckets=@buckets)
      buckets[index_of(key, buckets)]
    end

    def insert(key, value, buckets=@buckets)
      bucket_for(key, buckets) << [key, value]
    end

    def replace(key, value)
      bucket = bucket_for(key)
      bucket.each do |pair|
        pair[1] = value if pair[0] == key
      end
      value
    end

    def resize_buckets
      new_buckets = Array.new(2*@buckets.length) { [] }
      @buckets.each do |bucket|
        bucket.each do |key, val|
          insert(key, val, new_buckets)
        end
      end

      @buckets = new_buckets
    end
end
