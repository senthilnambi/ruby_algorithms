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

  it 'returns nil if argument is not deleted' do
    subject.delete('non existent').should == nil
  end

  it 'deletes all occurances when they occur near head' do
    list = described_class.new
    list << 'head'
    list << 'head'
    list.delete('head')
    list.count.should == 0
  end

  it 'deletes two heads' do
    list = described_class.new
    list << 'head'
    list << 'head'
    list << 'tail'
    list.delete('head')
    list.count.should == 1
  end

  it 'deletes in middle' do
    subject.delete('two')
    subject.count.should == 3
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

  it 'finds data which match a single argument' do
    subject.find('tail').should == 'tail'
  end

  it 'finds data which match block' do
    subject.find do |data|
      data == 'tail'
    end.should == 'tail'
  end

  it 'find data which match block and returns array if more than 1' do
    subject << 'tails'

    subject.find do |data|
      data.include?('tail')
    end.should == ['tails', 'tail']
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
