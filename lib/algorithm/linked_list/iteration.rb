module Algorithm

  # Contains Enumerable like methods.
  module Iteration

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
    # Examples:
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
        current_node = current_node.head
      end
    end

    # Yields each node.
    #
    # Examples:
    #   linked_list.each do |data|
    #     puts data
    #   end
    #
    #   #=> 'tail'
    #       'head'
    #
    def each
      each_node { |node| yield node.data }
    end

    # Yields each node and saves the output in an Array.
    #
    # Examples:
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

    # Finds all nodes whose data is exact match to argument or finds node
    # which return true for block passed in.
    #
    # Accepts:
    #   data - Object.
    #
    # Examples:
    #   linked_list.select do |data|
    #     data[0] == 'h'
    #   end
    #
    #   #=> [#<Algorithm::SingleNode:0x007fd51e07e680 @data="head">,
    #        #<Algorithm::SingleNode:0x007fd51e07e680 @data="hour">]
    #
    #   linked_list.select('hour')
    #   #=> #<Algorithm::SingleNode:0x007fd51e07e680 @data="hour">
    #
    # Returns:
    #   Array for multiple results,
    #   String for single result.
    #
    def select(data=nil, &user_blk)
      blk = user_blk || default_select_blk(data)

      result = [].tap do |arr|
        each_node do |node|
          arr << node if blk.call(node.data)
        end
      end

      result.size == 1 ? result.first : result
    end
    alias :select_all :select
    alias :find :select
    alias :find_all :select

    # Finds first nodes whose data is exact match to argument or finds
    # first node which return true for block passed in.
    #
    # Accepts:
    #   data - Object.
    #
    # Examples:
    #   linked_list.select_one do |data|
    #     data[0] == 'h'
    #   end
    #
    #   #=> #<Algorithm::SingleNode:0x007fd51e07e680 @data="head">
    #
    #   linked_list.select('hour')
    #   #=> #<Algorithm::SingleNode:0x007fd51e07e680 @data="hour">
    #
    # Returns:
    #   Node if found,
    #   else nil.
    #
    def select_one(data=nil, &user_blk)
      blk = user_blk || default_select_blk(data)

      result = [].tap do |arr|
        each_node do |node|
          if blk.call(node.data)
            arr << node 
            break
          end
        end
      end

      result.size > 0 ? result.first : nil
    end
    alias :find_one :select_one

    # Yields each node with a self incrementing index, starting at 0.
    #
    # Examples:
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

    # Returns: Array with all the data.
    def to_a
      map { |data| data }
    end

    private

    # Private: Finder methods use this as criteria to match nodes if
    # no node is provided.
    #
    def default_select_blk(data)
      proc { |node_data| node_data == data }
    end
  end
end
