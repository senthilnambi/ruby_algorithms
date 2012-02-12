require 'spec_helper'
require 'algorithm/linked_list/double_linked_list'

describe Algorithm::DoubleLinkedList do
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

  it do
    subject.previous.data.should == 'two'
  end

  it do
    subject.head.tail.should == nil
  end

  it do
    subject.tail.tail.data.should == 'two'
  end
end
