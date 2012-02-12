require_relative 'iteration'

module Algorithm
  # LinkedList is a simple data structure where the nodes/elements are
  # grouped/linked together. Similar to Array, but faster insertion
  # and deletions of nodes.
  #
  # SingleLinkedList is a type of LinkedList where each nodes have link
  # to previous node.
  #
  # For more info see: https://en.wikipedia.org/wiki/Linked_list
  #
  class SingleLinkedList
    include Iteration

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
      @tail = SingleNode.new(data, @tail)
      @head ||= @tail
      @size += 1

      self
    end
    alias :push :<<

    # Removes the last node.
    def pop
      popped = @tail
      @tail  = @tail.head # remove tail
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
          @tail = @tail.head
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
          holder.head = current.head # remove node
          @size -= 1
          deleted = true
        else
          # move holder one to the right
          holder = current
        end

        # move cursor one to the right
        current = current.head
      end

      data if deleted
    end

    def previous
      @tail.head.data
    end
  end

  class SingleNode
    attr_accessor :data, :head

    def initialize(data, node=nil)
      @data = data
      @head = node
    end

    def head?
      @head.nil?
    end
  end
end
