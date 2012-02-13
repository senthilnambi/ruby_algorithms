require 'spec_helper'
require 'algorithm/linked_list/double_linked_list'

describe Algorithm::DoubleLinkedList do
  let(:list) do
    described_class.new
  end

  let(:double_node_const) do
    Algorithm::DoubleNode
  end

  let(:zero_node) do
    list
  end

  let(:one_node) do
    list << 'one'
  end

  let(:multiple_nodes) do
    list << 'one'
    list << 'two'
    list << 'three'
    list << 'four'
    list << 'five'
  end

  context '#<<' do
    it 'adds to end in empty list' do
      zero_node.push('one')
      zero_node.to_a.should == ['one']
    end

    it 'adds to end in any list' do
      one_node.push('two')
      one_node.to_a.should == ['two', 'one']
    end

    it 'aliased to #push' do
      zero_node.push('one')
      zero_node.to_a.should == ['one']
    end

    it 'returns self' do
      multiple_nodes.push('six').should == multiple_nodes
    end
  end

  context '#pop'do
    it 'empty list returns nil' do
      zero_node.pop.should == nil
    end

    it 'decrements @size' do
      one_node.pop
      one_node.size.should == 0
    end

    it 'returns data of item popped' do
      multiple_nodes.pop.should == 'five'
    end

    it 'removes node from list' do
      multiple_nodes.pop
      multiple_nodes.to_a.should == ['four', 'three', 'two', 'one']
    end
  end

  context '#empty?' do
    it 'returns true for empty list' do
      zero_node.empty?.should == true
    end

    it 'returns false for full list' do
      one_node.empty?.should == false
    end
  end

  context '#size' do
    it 'is set to 0 at #initialize' do
      zero_node.size.should == 0
    end

    it 'returns @size' do
      multiple_nodes.size.should == 5
    end
  end

  context '#count' do
    it 'goes through #each_node and counts them' do
      multiple_nodes.count.should == 5
    end
  end

  context '#head' do
    it 'nil for empty list' do
      zero_node.head.should == nil
    end

    it 'first added node for single node list' do
      one_node.head.data.should == 'one'
    end

    it 'first added node for any list' do
      multiple_nodes.head.data.should == 'one'
    end

    it 'has no other heads' do
      multiple_nodes.head.head.should == nil
    end
  end

  context '#tail' do
    it 'nil for empty list' do
      zero_node.tail.should == nil
    end

    it 'last added node for single node list' do
      one_node.tail.data.should == 'one'
    end

    it 'last added node for any list' do
      multiple_nodes.tail.data.should == 'five'
    end

    it 'has no other tails' do
      multiple_nodes.tail.tail.should == nil
    end

    it 'traverses all the way to head' do
      multiple_nodes.tail.head.head.data.should           == 'three'
      multiple_nodes.tail.head.head.head.data.should      == 'two'
      multiple_nodes.tail.head.head.head.head.data.should == 'one'
    end
  end
end

describe Algorithm::DoubleNode do
  subject do
    described_class.new(:data => 'head')
  end

  context '#head?' do
    it 'returns true if no link to another node' do
      subject.head?.should == true
    end

    it 'return false if link to another node' do
      node = described_class.new(:data => 'tail', :tail => subject,
                                 :head => subject)
      node.head?.should == false
    end
  end
end
