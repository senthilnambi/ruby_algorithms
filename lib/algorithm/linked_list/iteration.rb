module Algorithm
  module Iteration

    # Finds data which is exact match to argument or finds data
    # which return true for block passed in.
    #
    # data - Object.
    #
    # Examples:
    #
    #   linked_list.find do |data|
    #     data[0] == 'h'
    #   end
    #
    #   #=> ['head']
    #
    #   linked_list.find('head')
    #   #=> ['head]
    #
    # Returns Array for multiple results, data for single result.
    #
    def find(data=nil, &user_blk)
      default_blk = proc {|node_data| node_data == data }
      blk         = user_blk || default_blk

      result = select(&blk)

      result.size == 1 ? result.first : result
    end

    # Recursively add up all nodes. Use @size for faster, but less
    # reliable answer.
    #
    def count
      index = 0
      each_node do |node|
        index += 1
      end

      index
    end

    # Recursively goes through the nodes and yields them individually.
    # Basis for all of the Enumerable like methods in the class.
    #
    #   linked_list.each_node do |node|
    #     puts node.data
    #   end
    #
    #   #=> 'head'
    #       'tail'
    #
    def each_node
      current_node = @tail

      while current_node
        yield current_node
        current_node = current_node.tail
      end
    end

    # Yields each node.
    #
    #   linked_list.each do |data|
    #     puts data
    #   end
    #
    #   #=> 'head'
    #       'tail'
    #
    def each
      each_node { |node| yield node.data }
    end

    # Yields each node and saves the output in an Array.
    #
    #   linked_list.map do |node|
    #     data.size
    #   end
    #
    #   #=> [4, 4]
    #
    def map
      [].tap do |arr|
        each do |data|
          arr << yield(data)
        end
      end
    end

    # Selects data which return true for block passed in.
    #
    #   linked_list.select do |data|
    #     data[0] == 'h'
    #   end
    #
    #   #=> ['head']
    #
    def select
      [].tap do |arr|
        each do |data|
          arr << data if yield(data)
        end
      end
    end

    # Yields each node with a self incrementing index, starting at 0.
    #
    #   arr = []
    #   linked_list.with_index do |data, index|
    #     arr << [data, index]
    #   end
    #
    #   #=> [['head', 0], ['tail', 1]]
    #
    def with_index
      index = 0
      each do |data|
        yield(data, index)
        index += 1
      end
    end

    # Returns Array with all the data.
    def to_a
      map { |data| data }
    end
  end
end
