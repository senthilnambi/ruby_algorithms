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

  let(:multiple_node_array) do
    ['five', 'four', 'three', 'two', 'one']
  end

  let(:multiple_node_array_reverse) do
    ["one", "two", "three", "four", "five"]
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

    it 'previous tail points to new tail' do
      arr = ['one', 'two', 'three', 'four', 'five', 'six']

      multiple_nodes.push('six')
      multiple_nodes.to_a_reverse.should == arr
    end

    it 'new node points to old tail' do
      arr = ['six', 'five', 'four', 'three', 'two', 'one']

      multiple_nodes.push('six')
      multiple_nodes.to_a.should == arr
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
      arr = ['one', 'two', 'three', 'four']

      multiple_nodes.pop
      multiple_nodes.to_a_reverse.should == arr
    end

    it 'returns data of item popped' do
      multiple_nodes.pop.should == 'five'
    end
  end

  context '#reverse' do
    it 'populates array from reverse' do
      multiple_nodes.to_a_reverse.should == multiple_node_array_reverse
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

    it 'points to right tail' do
      multiple_nodes.head.tail.data.should == 'two'
    end

    it 'traverses all the way from head to tail' do
      multiple_nodes.head.data.should                     == 'one'
      multiple_nodes.head.tail.data.should                == 'two'
      multiple_nodes.head.tail.tail.data.should           == 'three'
      multiple_nodes.head.tail.tail.tail.data.should      == 'four'
      multiple_nodes.head.tail.tail.tail.tail.data.should == 'five'
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

    it 'points to right head' do
      multiple_nodes.tail.head.data.should == 'four'
    end

    it 'has no other tails' do
      multiple_nodes.tail.tail.should == nil
    end

    it 'traverses all the way from tail to head' do
      multiple_nodes.tail.data.should                     == 'five'
      multiple_nodes.tail.head.data.should                == 'four'
      multiple_nodes.tail.head.head.data.should           == 'three'
      multiple_nodes.tail.head.head.head.data.should      == 'two'
      multiple_nodes.tail.head.head.head.head.data.should == 'one'
    end
  end

  context '#insert' do
    context 'zero nodes' do
      before do
        zero_node.insert('tail')
      end

      it 'adds to end of list if position' do
        zero_node.to_a.should == ['tail']
      end

      it 'increases @size when adding to empty list' do
        zero_node.size.should == 1
      end
    end

    context '#replace' do
      it 'replaces in the middle' do
        arr = ['five', 'four', 'three', 'new two', 'one']

        multiple_nodes.insert('new two', :replace => 'two')
        multiple_nodes.to_a.should == arr
      end

      it 'replaces head for multiple nodes' do
        arr = ['five', 'four', 'three', 'two', 'new one']

        multiple_nodes.insert('new one', :replace => 'one')
        multiple_nodes.to_a.should == arr
      end

      it 'replaces tail for one node' do
        one_node.insert('new one', :replace => 'one')
        one_node.to_a.should == ['new one']
      end

      it 'replaces tail for two nodes' do
        two_nodes.insert('new two', :replace => 'two')
        two_nodes.to_a.should == ['new two', 'one']
      end

      it 'replaces tail for multiple nodes' do
        arr = ['new five', 'four', 'three', 'two', 'one']

        multiple_nodes.insert('new five', :replace => 'five')
        multiple_nodes.to_a.should == arr
      end

      it 'does nothing if position is not found' do
        multiple_nodes.insert('new two', :replace => 'fake')
        multiple_nodes.to_a.should ==  multiple_node_array
      end

      it 'returns nil if position not found' do
        multiple_nodes.insert('new two', :replace => 'fake').should == nil
      end

      it 'does nothing to @size' do
        multiple_nodes.insert('new one', :replace => 'one')
        multiple_nodes.size.should == 5
      end

      it 'count remains at 5' do
        multiple_nodes.insert('new one', :replace => 'one')
        multiple_nodes.count.should == 5
      end

      it 'returns true if successful' do
        multiple_nodes.insert('new one', :replace => 'one').should == true
      end

      it 'throws error if more than one insertion' do
        doing do
          multiple_nodes.insert('fake', :before => 'one', :after => 'two')
        end.should raise_error('only one insertion allowed')
      end
    end

    context '#before' do
      it 'inserts in the right position' do
        arr = ['five', 'four', 'three', 'new two', 'two', 'one']

        multiple_nodes.insert('new two', :before => 'three')
        multiple_nodes.to_a.should == arr
      end

      it 'does nothing if position is not found' do
        multiple_nodes.insert('new two', :before => 'fake')
        multiple_nodes.to_a.should ==  multiple_node_array
      end

      it 'returns nil if position not found' do
        multiple_nodes.insert('new two', :before => 'fake').should == nil
      end
    end

    context '#after' do
      it 'inserts in the right position' do
        arr = ['five', 'four', 'three', 'new two', 'two', 'one']

        multiple_nodes.insert('new two', :after => 'two')
        multiple_nodes.to_a.should == arr
      end

      it 'does nothing if position is not found' do
        multiple_nodes.insert('new two', :after => 'fake')
        multiple_nodes.to_a.should ==  multiple_node_array
      end

      it 'returns nil if position not found' do
        multiple_nodes.insert('new two', :after => 'fake').should == nil
      end
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
