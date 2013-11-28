require 'linked_list.rb'

class Stack < LinkedList
  alias_method :size, :length

  def initialize
    super
    @max_history = []
  end

  def max
    @max_history.last
  end

  def push(value)
    super
    update_max(value)
  end

  def <<(value)
    super
    update_max(value)
  end

  def pop
    @max_history.pop
    super
  end

  private
    def update_max(value)
      current_max = @max_history.last
      if current_max.nil? || value > current_max 
        @max_history << value
      else
        @max_history << current_max
      end
    end
end
