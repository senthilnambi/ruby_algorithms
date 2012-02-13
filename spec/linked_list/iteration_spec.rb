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

    it 'selects data which return true for block' do
      subject.select { |x| x == 'three'}.first.should == 'three'
    end

    it 'selects node which return true for block' do
      subject.select_node { |x| x == 'three'}.first.data.should == 'three'
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

    context '#find' do
      it 'data which match a single argument' do
        subject.find('one').should == 'one'
      end

      it 'data which match block' do
        subject.find do |data|
          data == 'one'
        end.should == 'one'
      end

      it 'data which match block and returns array if more than one' do
        subject << 'ones'

        subject.find do |data|
          data.include?('one')
        end.should == ['ones', 'one']
      end
    end

    context '#find_node' do
      it 'returns Algorithm::Node subclass' do
        subject.find_node('one').should be_a(Algorithm::Node)
      end

      it 'data which match a single argument' do
        subject.find_node('one').data.should == 'one'
      end

      it 'data which match block' do
        subject.find_node do |data|
          data == 'one'
        end.data.should == 'one'
      end

      it 'data which match block and returns array if more than one' do
        subject << 'ones'

        arr = subject.find_node do |data|
          data.include?('one')
        end

        arr.collect(&:data).should == ['ones', 'one']
      end
    end
  end
end
