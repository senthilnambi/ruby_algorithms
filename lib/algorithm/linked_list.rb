module Algorithm
  # LinkedList is a simple data structure where the nodes/elements are
  # grouped/linked together. Similar to Array, but faster insertion
  # and deletions of nodes.
  #
  # For more info see: https://en.wikipedia.org/wiki/Linked_list
  #
  class LinkedList
    attr_reader :head, :tail, :size

    def initialize
      @size = 0
    end

    # Adds argument to LinkedList, with reference to previous added.
    # Last added is stored in @tail. First added is stored in @head.
    #
    # data - Object.
    #
    # Examples:
    #
    #   linked_list = LinkedList.new
    #   linked_list << 'head'
    #   linked_list << 'tail'
    #
    def <<(data)
      @tail = Node.new(data, @tail)
      @head ||= @tail
      @size += 1

      self
    end
    alias :push :<<

    # Removes the last node.
    def pop
      popped = @tail
      @tail  = @tail.previous # remove tail
      @size -= 1

      popped.data
    end

    # Recursively removes all instances of argument.
    #
    # Returns argument if it was deleted, else nil.
    #
    def delete(data)

      # used to determine what to output at end: argument or nil.
      deleted = nil

      # removes tail if it has data, loop for cases where multiple
      # existences of data exist near tail.
      #
      while @tail
        if @tail.data == data
          @tail = @tail.previous
          @size -= 1
          deleted = true
        else
          break
        end
      end

      # cursor vars to track nodes on the left
      holder  = nil
      current = @tail

      # loop through LinkedList and remove data if it exists
      while current

        # if data exists, don't move holder to the right, i.e. to the
        # node with the data, which was deleted.
        #
        if current.data == data
          holder.previous = current.previous # remove node
          @size -= 1
          deleted = true
        else
          # move holder one to the right
          holder = current
        end

        # move cursor one to the right
        current = current.previous
      end

      data if deleted
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

    def previous
      @tail.previous.data
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
        current_node = current_node.previous
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
      arr = []

      each { |data| arr << yield(data) }

      arr
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
      arr = []

      each { |data| arr << data if yield(data) }

      arr
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

  class Node
    attr_accessor :data, :previous

    def initialize(data, node=nil)
      @data     = data
      @previous = node
    end

    def head?
      @previous.nil?
    end
  end
end
