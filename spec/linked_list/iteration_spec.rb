require 'spec_helper'
require 'algorithm/linked_list/single_linked_list'

describe Algorithm::Iteration do

  # works with Algorithm::DoubleLinkedList as well
  subject { Algorithm::SingleLinkedList.new }

  before do
    subject << 'head'
    subject << 'one'
    subject << 'two'
    subject << 'tail'
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

  it 'yield data in each node' do
    [].tap do |arr|
      subject.each do |x|
        arr << x
      end
    end.should == ['tail', 'two', 'one', 'head']
  end

  it 'yields each node and collects result in an array' do
    subject.map { |x| x}.should == ['tail', 'two', 'one', 'head']
  end

  it 'selects data which return true for block' do
    subject.select { |x| x == 'tail'}.first.should == 'tail'
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
end
