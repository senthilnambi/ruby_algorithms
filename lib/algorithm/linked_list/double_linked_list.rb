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
        else
          # list has only node
          popped = @head

          @head  = nil
          @tail  = nil
        end

        @size     -= 1
        return popped.data
      else

        # list has no nodes
        return nil
      end
    end

    def empty?
      !@head && !@tail
    end

    def replace(data, position_data)
      # TODO: DRY this
      position = select_node {|node_data| node_data == position_data}
      return nil unless position && !position.empty?

      # TODO: change select to return nil or first node, not array
      position = position.first
      node = DoubleNode.new(:data => data)

      # if position is the first node
      head = position.head
      tail = position.tail

      # before: head -> position -> tail
      # after:  head -> node -> tail
      head.tail = node if head
      node.tail = tail
      tail.head = node if tail
      node.head = head

      # set @tail for list or it will use old tail
      if position.tail?
        @tail = node
      end

      # orphan the old node
      position.head = nil
      position.tail = nil
    end

    def insert_before(data, position_data=nil)
      insert_at(data, position_data)
    end

    def insert_after(data, position_data=nil)
      # TODO: DRY these
      unless position_data
        push(data)
        return
      end

      position = select_node {|node_data| node_data == position_data}
      return nil unless position && !position.empty?

      # TODO: select_node returns array
      position = position.first

      # if position_data is tail, use <<
      position_data = if position.tail
        position.tail.data
      else
        nil
      end

      insert_at(data, position_data)
    end

    private

    # TODO: same behavior as insert_before. Am I doing it wrong?
    def insert_at(data, position_data=nil)
      unless position_data
        push(data)
        return
      end

      position = select_node {|node_data| node_data == position_data}

      return 'position not found' unless position && !position.empty?

      # TODO: change select to return nil or first node, not array
      position = position.first
      node = DoubleNode.new(:data => data)

      # if position is the first node
      head = position.head unless position.head?
      tail = position.tail

      # before: head -> position
      # after:  head -> node -> position
      head.tail = node if head
      node.tail = position
      position.head = node
      node.head = head

      @size += 1
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
