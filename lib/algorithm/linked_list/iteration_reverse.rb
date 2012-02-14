module Algorithm
  module IterationReverse

    # Yields each node in reverse.
    #
    #   linked_list.each do |data|
    #     puts data
    #   end
    #
    #   #=> 'head'
    #       'tail'
    #
    def reverse
      current_node = @head

      while current_node
        yield current_node.data
        current_node = current_node.tail
      end
    end

    # Yields each node in reverse and saves the output in an Array.
    #
    #   linked_list.map do |node|
    #     data.size
    #   end
    #
    #   #=> [4, 4]
    #
    def map_reverse
      [].tap do |arr|
        reverse do |data|
          arr << yield(data)
        end
      end
    end

    # Returns Array with all the data in reverse.
    def to_a_reverse
      map_reverse {|x| x}
    end
  end
end
