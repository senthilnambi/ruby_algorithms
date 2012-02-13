module Algorithm
  class Node
    attr_accessor :data, :head

    def head?
      @head.nil?
    end

    def tail?
      @tail.nil?
    end
  end
end
