require 'benchmark/ips'
require_relative '../lib/trie.rb'

Benchmark.ips do |x|
  x.config(:warmup => 2, :time => 10)

  # Prep work
  trie  = Trie.new
  words = []

  File.foreach('/usr/share/dict/words') do |x|
    word = x.chomp
    trie.insert(word)
    words << word
  end

  x.report("With trie") { trie.completions_for("fast") }

  x.report("With direct comparison") do
      words.select { |word| word.start_with?("fast") }
  end

  x.compare!
end

