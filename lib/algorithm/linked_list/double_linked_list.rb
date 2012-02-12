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

    attr_reader :head, :tail

    def <<(data)
      @tail = DoubleNode.new(:data => data, :tail => @tail, 
                             :head => @head)
      @head ||= @tail
    end

    def previous
      @tail.tail
    end
  end

  class DoubleNode
    attr_reader :data, :tail, :head

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
