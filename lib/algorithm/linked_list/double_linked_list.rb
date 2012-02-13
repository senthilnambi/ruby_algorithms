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

    # Adds argument to list, along with link to previous node, which
    # in turn has link to this new node.
    # Last added is stored in @tail. First added is stored in @head.
    #
    # data - Object.
    #
    # Examples:
    #
    #   list = DoubleLinkedList.new
    #   list << 'head'
    #   list << 'tail'
    #
    def <<(data)
      node = DoubleNode.new(:data => data)

      # list has nodes, add this to last
      if @tail
        @tail.tail = node
        node.head  = @tail

      # list empty, add first node
      else
        @head = node
      end

      # node always added to end of list
      @tail  = node
      @size += 1

      self
    end
    alias :push :<<

    # Removes the last node.
    def pop
      return nil unless @head && @tail

      old_data   = @tail.data
      @tail      = @tail.head
      @head.tail = @tail

      @size -= 1

      old_data
    end

    def empty?
      !@head && !@tail
    end

    def replace(data, position_data)
      # TODO: DRY this
      position = select_one {|node_data| node_data == position_data}
      return nil unless position

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

      true
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

      position = select_one {|node_data| node_data == position_data}
      return nil unless position

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

      position = select_one {|node_data| node_data == position_data}
      return nil unless position

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

      true
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
