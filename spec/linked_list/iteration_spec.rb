require 'algorithm/linked_list'

[Algorithm::DoubleLinkedList, Algorithm::SingleLinkedList].each do |klass|

  describe klass do
    subject { klass.new }

    let(:elem_array) do
      ['one', 'two', 'three', 'four', 'five']
    end

    let(:reverse_array) do
      elem_array.reverse
    end

    before(:each) do
      elem_array.each do |elem|
        subject << elem
      end
    end

    it 'yields each node' do
      [].tap do |arr|
        subject.each_node do |x|
          arr << x.data
        end
      end.should == reverse_array
    end

    it 'returns count' do
      subject.count.should == 5
    end

    it 'yield data in each node' do
      [].tap do |arr|
        subject.each do |x|
          arr << x
        end
      end.should == reverse_array
    end

    it 'yields each node and collects result in an array' do
      subject.map { |x| x}.should == reverse_array
    end

    it do
      subject.select { |x| x == 'three'}.data.should == 'three'
    end

    it do
      subject << 'three'
      subject.select { |x| x == 'three'}.size.should == 2
    end

    it do
      subject << 'three'
      subject.select { |x| x == 'three'}.first.data.should == 'three'
    end

    it 'select_one returns nil if no result found' do
      subject.select_one('imaginary').should == nil
    end

    it 'select_one returns nil if no result found (with block)' do
      subject.select_one {|x| x == 'imaginary'}.should == nil
    end

    it 'select_one returns' do
      subject.select_one { |x| x == 'three'}.data.should == 'three'
    end

    it 'returns data in an array' do
      subject.to_a.should == reverse_array
    end

    it 'yields data with self increasing index' do
      reverse_index_array = []
      index               = 0

      elem_array.reverse_each do |elem|
        reverse_index_array << [elem, index]
        index += 1
      end

      [].tap do |arr|
        subject.with_index do |data, index|
          arr << [data, index]
        end
      end.should == reverse_index_array
    end
  end
end
