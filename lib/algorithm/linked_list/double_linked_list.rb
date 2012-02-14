require_relative 'iteration'
require_relative 'iteration_reverse'
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
    include IterationReverse

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

      old_head      = @tail.head
      old_data      = @tail.data
      @tail         = @tail.head
      old_head.tail = nil if old_head

      @size -= 1

      old_data
    end

    def empty?
      !@head && !@tail
    end

    def insert(data, hash={})
      if hash.size == 0
        push(data)
        return
      elsif hash.size > 1
        raise 'only one insertion allowed'
      end

      replace = hash[:replace]
      before  = hash[:before]
      after   = hash[:after]

      # do only one operation per insert
      cursor_data = replace || after || before

      position = select_one {|node_data| node_data == cursor_data}
      return nil unless position

      if replace
        insert_at!(data, position)
      elsif after
        insert_at(data, position.tail)
      elsif before
        insert_at(data, position)
      end

      true
    end

    private

    def insert_at!(data, position)
      node, head, tail = set_insert_vars(data, position)

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

    def insert_at(data, position)
      node, head, tail = set_insert_vars(data, position)

      head.tail     = node if head
      node.tail     = position
      position.head = node
      node.head     = head

      @size += 1
    end

    # Private: variables common to insert_at and replace.
    #
    # Returns Array.
    #
    def set_insert_vars(data, position)
      node = create_node(data)

      head = position.head
      tail = position.tail

      [node, head, tail]
    end

    def create_node(data)
      DoubleNode.new(:data => data)
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
