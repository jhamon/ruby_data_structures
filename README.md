# Data Structures in Ruby [![Build Status](https://travis-ci.org/jhamon/ruby_data_structures.png)](https://travis-ci.org/jhamon/ruby_data_structures)

## Tech Inventory

- Ruby
- Rspec

## Description 

The purpose of this repository is for me to gain familiarity with common data
structures by TDDing my way through straightforward Ruby implementations.  I 
can't think of a better way to do that than by implementing them myself.

## Completed so far

- [Trie](lib/trie.rb)
- [Stack](lib/stack.rb)
- [Queue](lib/queue.rb)
- [LinkedList](lib/linked_list.rb)
- [MinHeap](lib/min_heap.rb)
- [MaxHeap](lib/max_heap.rb)
- [HashMap](lib/hashmap.rb)

## Trie

Tries are used to provide fast autocompletion.  Over the list of words present in my local `/usr/share/dict/words`, it appears that autocomplete with a trie is over 700x faster than simply looking through an array of words for matches.

```
$ ruby benchmarks/trie_benchmark.rb
Calculating -------------------------------------
           With trie       403 i/100ms
With direct comparison
                             1 i/100ms
-------------------------------------------------
           With trie     8086.4 (±33.9%) i/s -      43121 in  10.015687s
With direct comparison
                           11.1 (±44.9%) i/s -         65 in  10.083059s

Comparison:
           With trie:     8086.4 i/s
With direct comparison:       11.1 i/s - 726.95x slower

```
