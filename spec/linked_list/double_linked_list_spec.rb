require 'spec_helper'
require 'algorithm/linked_list/double_linked_list'

describe Algorithm::DoubleLinkedList do
  subject { described_class.new }

  context 'zero nodes' do
    it 'head is nil' do
      subject.head.should == nil
    end

    it 'tail is nil' do
      subject.tail.should == nil
    end

    it 'size is 0' do
      subject.size.should == 0
    end

    it 'count is 0' do
      subject.count.should == 0
    end

    it 'pops nothing' do
      subject.pop.should == nil
    end

    it 'empty is true' do
      subject.empty?.should == true
    end
  end

  context 'one node' do
    before do
      subject << 'one'
    end

    it 'head points to first node added' do
      subject.head.data.should == 'one'
    end

    it 'tail points to one nodel added' do
      subject.tail.data.should == 'one'
    end

    it 'size is 1' do
      subject.size.should == 1
    end

    it 'count is 1' do
      subject.count.should == 1
    end

    it 'pop returns data' do
      subject.pop.should == 'one'
    end

    it 'empty is false' do
      subject.empty?.should == false
    end

    context '#pop' do
      before do
        subject.pop
      end

      it 'tail is nil' do
        subject.tail.should == nil
      end

      it 'head is nil' do
        subject.head.should == nil
      end

      it 'size is 0' do
        subject.size.should == 0
      end

      it 'count is 0' do
        subject.count.should == 0
      end

      it 'empty is false' do
        subject.empty?.should == true
      end
    end
  end

  context 'two nodes' do
    before do
      subject << 'one'
      subject << 'two'
    end

    it 'head points to first node added' do
      subject.head.data.should == 'one'
    end

    it 'tail points to last node added' do
      subject.tail.data.should == 'two'
    end

    it 'size is 2' do
      subject.size.should == 2
    end

    it 'head has no other heads' do
      subject.head.head.should == nil
    end

    it 'head has one tail' do
      subject.head.tail.data.should == 'two'
    end

    it 'tail has no other tails' do
      subject.tail.tail.should == nil
    end

    it 'tail has one head' do
      subject.tail.head.data.should == 'one'
    end

    it 'pop returns data' do
      subject.pop.should == 'two'
    end

    context '#pop' do
      before do
        subject.pop
      end

      it 'moves tail to one before popped node' do
        subject.tail.data.should == 'one'
      end

      it 'head remains the same' do
        subject.head.data.should == 'one'
      end

      it 'size is 1' do
        subject.size.should == 1
      end
    end
  end

  context 'multiple nodes' do
    before do
      subject << 'one'
      subject << 'two'
      subject << 'three'
      subject << 'four'
      subject << 'five'
    end

    it 'head points to first node added' do
      subject.head.data.should == 'one'
    end

    it 'tail points to last node added' do
      subject.tail.data.should == 'five'
    end

    it 'size is 5' do
      subject.size.should == 5
    end

    it 'head has no other heads' do
      subject.head.head.should == nil
    end

    it 'head has one tail' do
      subject.head.tail.data.should == 'two'
    end

    it 'tail has no other tails' do
      subject.tail.tail.should == nil
    end

    it 'tail has one head' do
      subject.tail.head.data.should == 'four'
    end

    it 'traverses all the way to head' do
      subject.tail.head.head.data.should           == 'three'
      subject.tail.head.head.head.data.should      == 'two'
      subject.tail.head.head.head.head.data.should == 'one'
    end

    it 'pop returns data' do
      subject.pop.should == 'five'
    end

    context '#pop' do
      before do
        subject.pop
      end

      it 'moves tail to one before popped node' do
        subject.tail.data.should == 'four'
      end

      it 'new tail has no other tails' do
        subject.tail.tail.should == nil
      end

      it 'head remains the same' do
        subject.head.data.should == 'one'
      end

      it 'size is 4' do
        subject.size.should == 4
      end
    end
  end
end

describe Algorithm::DoubleNode do
  subject do
    described_class.new(:data => 'head')
  end

  it 'returns true if no link to another node' do
    subject.head?.should == true
  end

  it 'return false if link to another node' do
    node = described_class.new(:data => 'tail', :tail => subject,
                               :head => subject)
    node.head?.should == false
  end
end
