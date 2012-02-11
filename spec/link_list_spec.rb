require 'spec_helper'
require 'algorithm/linked_list'

describe 'LinkedList' do
  subject { Algorithm::LinkedList.new }

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

  it 'yields each node' do
    [].tap do |arr|
      subject.each_node do |x|
        arr << x.data
      end
    end.should == ['tail', 'two', 'one', 'head']
  end

  it 'returns count' do
    subject.count.should == 4
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
    list = Algorithm::LinkedList.new
    list << 'head'
    list << 'head'
    list.delete('head')
    list.count.should == 0
  end

  it 'deletes two heads' do
    list = Algorithm::LinkedList.new
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

  it 'yield data in each node' do
    [].tap do |arr|
      subject.each do |x|
        arr << x
      end
    end.should == ['tail', 'two', 'one', 'head']
  end

  it 'pushes to the end' do
    subject.push('hola')
    subject.count.should == 5
  end

  it 'pops the last node' do
    subject.pop
    subject.count.should == 3
  end

  it 'yields each node and collects result in an array' do
    subject.map { |x| x}.should == ['tail', 'two', 'one', 'head']
  end

  it 'selects data which return true for block' do
    subject.select { |x| x == 'tail'}.first.should == 'tail'
  end

  it 'returns 2nd last data' do
    subject.previous.should == 'two'
  end

  it 'returns data in an array' do
    subject.to_a.should == ['tail', 'two', 'one', 'head']
  end

  it 'yields data with self increasing index' do
    [].tap do |arr|
      subject.with_index do |data, index|
        arr << [data, index]
      end
    end.should == [["tail", 0], ["two", 1], ["one", 2], ["head", 3]]
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

describe 'Node' do
  subject { Algorithm::Node.new('head', nil) }

  it 'returns true if no link to another node' do
    subject.head?.should == true
  end

  it 'return false if link to another node' do
    node = Algorithm::Node.new('tail', subject)
    node.head?.should == false
  end
end
