require 'spec_helper'
require 'algorithm/linked_list/single_linked_list'

describe Algorithm::SingleLinkedList do
  subject { described_class.new }

  before do
    subject << 'head'
    subject << 'one'
    subject << 'two'
    subject << 'tail'
  end

  it 'returns head' do
    subject.head.data.should == 'head'
  end

  it 'returns tail' do
    subject.tail.data.should == 'tail'
  end

  context '#delete' do
    it 'deletes tail' do
      subject.delete('tail')
      subject.count.should == 3
    end

    it 'deletes in middle' do
      subject.delete('one')
      subject.count.should == 3
    end

    it 'deletes head' do
      subject.delete('head')
      subject.count.should == 3
    end

    it 'deletes all occurances' do
      subject << 'one'
      subject.delete('one')
      subject.count.should == 3
    end

    it 'deletes all occurances when they occur near tail' do
      subject << 'tail'
      subject.delete('tail')
      subject.count.should == 3
    end

    it 'returns argument if argument is deleted' do
      subject.delete('tail').should == 'tail'
    end

    it 'returns nil if argument is not in list' do
      subject.delete('non existent').should == nil
    end

    context 'head and next node with same data' do
      let(:list) do
        described_class.new
      end

      before do
        list << 'head'
        list << 'head'
      end

      it 'deletes all occurances when they occur near head' do
        list.delete('head')
        list.count.should == 0
      end

      it 'deletes two heads' do
        list << 'tail'
        list.delete('head')
        list.count.should == 1
      end
    end

    it 'deletes in middle' do
      subject.delete('two')
      subject.count.should == 3
    end
  end

  it 'pushes to the end' do
    subject.push('hola')
    subject.count.should == 5
  end

  it 'pops the last node' do
    subject.pop
    subject.count.should == 3
  end

  it 'returns 2nd last data' do
    subject.previous.should == 'two'
  end
end

describe Algorithm::SingleNode do
  subject do
    described_class.new('head', nil)
  end

  it 'returns true if no link to another node' do
    subject.head?.should == true
  end

  it 'return false if link to another node' do
    node = described_class.new('tail', subject)
    node.head?.should == false
  end
end
