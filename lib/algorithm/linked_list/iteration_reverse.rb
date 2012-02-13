module Algorithm
  module IterationReverse
    def reverse
      current_node = @head

      while current_node
        yield current_node.data
        current_node = current_node.tail
      end
    end

    def map_reverse
      [].tap do |arr|
        reverse do |data|
          arr << yield(data)
        end
      end
    end

    def to_a_reverse
      map_reverse {|x| x}
    end
  end
end
