require 'linked_list.rb'

class Stack < LinkedList
  alias_method :size, :length
end
