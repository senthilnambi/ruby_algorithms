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

      # list has nodes, add this to last
      if @tail
        @tail.tail = node
        node.head  = tail

      # list empty, add first node
      else
        @head = node
      end

      @tail = node

      self
    end
    alias :push :<<

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

    def insert_after(data, cursor=nil)
      insert_wrapper(data, cursor) do |node|
        tail = cursor.tail

        # cursor -> tail
        # cursor -> node -> tail
        cursor.tail = node
        node.head   = cursor
        node.tail   = tail
        tail.head   = node
      end
    end

    def insert_before(data, cursor=nil)
      insert_wrapper(data, cursor) do |node|
        head = cursor.head

        # head -> cursor
        # head -> node -> cursor
        head.tail   = node
        node.head   = head
        node.tail   = cursor
        cursor.head = node
      end
    end

    def previous
      @tail.head
    end

    def empty?
      !@head && !@tail
    end

    private

    def insert_wrapper(data, cursor)
      unless cursor
        # add to end of list
        push(data)
        return
      end

      node = DoubleNode.new(:data => data)
      yield node

      @size += 1
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
