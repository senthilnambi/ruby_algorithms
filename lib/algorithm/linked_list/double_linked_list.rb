require_relative 'iteration'
require_relative 'node'

module Algorithm
  # LinkedList is a simple data structure where the nodes/elements are
  # grouped/linked together. Similar to Array, but faster insertion
  # and deletions of nodes.
  #
  # DoubleLinkedList is a type of LinkedList where each nodes have link
  # to previous and next nodes.
  #
  # For more info see: https://en.wikipedia.org/wiki/Linked_list
  #
  class DoubleLinkedList
    include Iteration

    attr_reader :head, :tail, :size

    def initialize
      @size = 0
    end

    def <<(data)
      node = DoubleNode.new(:data => data)

      @size += 1

      # list has nodes, add this to last
      if @tail
        @tail.tail = node
        node.head  = tail

      # list empty, add first node
      else
        @head = node
      end

      # node always added to end of list
      @tail = node

      self
    end
    alias :push :<<

    def pop
      if @head && @tail

        # list has multiple nodes
        unless @head == @tail
          popped     = @tail
          @tail      = @tail.head
          @tail.tail = nil
          @size     -= 1

          return popped.data
        else
          # list has only node
          popped = @head

          @head  = nil
          @tail  = nil
          @size -= 1

          return popped.data
        end

      else

        # list has no nodes
        return nil
      end
    end

    def empty?
      !@head && !@tail
    end

    def insert_at(data, position_data)
    end
  end

  class DoubleNode < Node
    attr_accessor :tail

    def initialize(hash)
      @data = hash[:data]
      @tail = hash[:tail]
      @head = hash[:head]
    end
  end
end
