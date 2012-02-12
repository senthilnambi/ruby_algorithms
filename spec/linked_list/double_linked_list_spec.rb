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
