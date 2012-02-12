require_relative 'iteration'

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

      # list has head & tail, add to last
      if @head && @tail
        @tail.tail = node
        node.head  = tail

      # list has one node, add second node
      elsif @head && @head.tail.nil?
        @head.tail = node
        node.head  = head

      # list empty, add first node
      elsif @tail.nil? && @head.nil?
        @head = node
      end

      @tail = node

      self
    end

    def pop
      if @head && @tail

        # list has only node
        if @head == @tail
          popped = @head

          @head = nil
          @tail = nil
          @size -= 1

          return popped.data

        # list has multiple nodes
        else
          popped     = @tail
          @tail      = @tail.head
          @tail.tail = nil
          @size -= 1

          return popped.data
        end
      else

        # list has no nodes
        return nil
      end
    end

    def previous
      @tail.head
    end

    def empty?
      !@head && !@tail
    end
  end

  class DoubleNode
    attr_accessor :data, :tail, :head

    def initialize(hash)
      @data = hash[:data]
      @tail = hash[:tail]
      @head = hash[:head]
    end

    def head?
      @head.nil?
    end
  end
end
