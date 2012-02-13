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

  let(:two_nodes) do
    list = described_class.new
    list << 'one'
    list << 'two'
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

    it 'removes node from list' do
      multiple_nodes.pop
      multiple_nodes.to_a.should == ['four', 'three', 'two', 'one']
    end

    it 'returns data of item popped' do
      multiple_nodes.pop.should == 'five'
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

  context '#insert_before' do
    context 'zero nodes' do
      before do
        zero_node.insert_before('tail')
      end

      it 'adds to end of list if position' do
        zero_node.to_a.should == ['tail']
      end

      it 'increases @size when adding to empty list' do
        zero_node.size.should == 1
      end
    end

    it 'inserts in the right position' do
      arr = ['five', 'four', 'three', 'two', 'two.five', 'one']

      multiple_nodes.insert_before('two.five', 'two')
      multiple_nodes.to_a.should == arr
    end

    it 'does nothing if position is not found' do
      # use let for these arr
      arr = ['five', 'four', 'three', 'two', 'one']

      multiple_nodes.insert_before('new one', 'imaginary')
      multiple_nodes.to_a.should ==  arr
    end

    it 'informs user position not found' do
      multiple_nodes.insert_before('new one', 'imaginary').
        should == 'position not found'
    end

    it 'inserts before head' do
      arr = ['five', 'four', 'three', 'two', 'one', 'new one']

      multiple_nodes.insert_before('new one', 'one')
      multiple_nodes.to_a.should == arr
    end

    it 'increases @size when adding to full list' do
      multiple_nodes.insert_before('new one', 'one')
      multiple_nodes.size.should == 6
    end
  end

  context '#insert_after' do
    context 'zero nodes' do
      before do
        zero_node.insert_after('tail')
      end

      it 'adds to end of list if position' do
        zero_node.to_a.should == ['tail']
      end

      it 'increases @size when adding to empty list' do
        zero_node.size.should == 1
      end
    end

    it 'inserts in the right position' do
      arr = ['five', 'four', 'three', 'two', 'two.five', 'one']

      multiple_nodes.insert_after('two.five', 'one')
      multiple_nodes.to_a.should == arr
    end

    it 'does nothing if position is not found' do
      # use let for these arr
      arr = ['five', 'four', 'three', 'two', 'one']

      multiple_nodes.insert_after('two.five', 'imaginary')
      multiple_nodes.to_a.should ==  arr
    end

    it 'informs user position not found' do
      multiple_nodes.insert_after('two.five', 'imaginary').
        should == 'position not found'
    end

    it 'inserts at tail' do
      arr = ['new five', 'five', 'four', 'three', 'two', 'one']

      multiple_nodes.insert_after('new five', 'five')
      multiple_nodes.to_a.should == arr
    end

    it 'increases @size when adding to full list' do
      multiple_nodes.insert_before('new one', 'one')
      multiple_nodes.size.should == 6
    end
  end

  context '#replace' do
    it 'replaces tail when only one node' do
      one_node.replace('new one', 'one')
      one_node.to_a.should == ['new one']
    end

    it 'replaces tail when only two nodes' do
      two_nodes.replace('new two', 'two')
      two_nodes.to_a.should == ['new two', 'one']
    end

    it 'does nothing if position is not found' do
      # use let for these arr
      arr = ['five', 'four', 'three', 'two', 'one']

      multiple_nodes.replace('two.five', 'imaginary')
      multiple_nodes.to_a.should ==  arr
    end

    it 'informs user position not found' do
      multiple_nodes.replace('two.five', 'imaginary').
        should == 'position not found'
    end

    it 'replace in the right position' do
      arr = ['five', 'four', 'three', 'new two', 'one']

      multiple_nodes.replace('new two', 'two')
      multiple_nodes.to_a.should == arr
    end

    it 'replaces head' do
      arr = ['five', 'four', 'three', 'two', 'new one']

      multiple_nodes.replace('new one', 'one')
      multiple_nodes.to_a.should == arr
    end

    it 'replaces tail' do
      arr = ['new five', 'four', 'three', 'two', 'one']

      multiple_nodes.replace('new five', 'five')
      multiple_nodes.to_a.should == arr
    end

    it 'does nothing to @size' do
      multiple_nodes.replace('new one', 'one')
      multiple_nodes.size.should == 5
    end

    it 'count remains at 5' do
      multiple_nodes.replace('new one', 'one')
      multiple_nodes.count.should == 5
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
