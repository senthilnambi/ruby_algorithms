require 'algorithm/linked_list'

describe Algorithm::DoubleLinkedList do
  subject { described_class.new }

  let(:elem_array) do
    ['one', 'two', 'three', 'four', 'five']
  end

  before(:each) do
    elem_array.each do |elem|
      subject << elem
    end
  end

  it 'yields each node' do
    [].tap do |arr|
      subject.reverse do |x|
        arr << x
      end
    end.should == elem_array
  end

  it 'yields each node and collects result in an array' do
    subject.map_reverse { |x| x}.should == elem_array
  end

  it 'returns data in an array' do
    subject.to_a_reverse.should == elem_array
  end
end
