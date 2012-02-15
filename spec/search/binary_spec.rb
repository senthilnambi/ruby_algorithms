require 'spec_helper'
require 'algorithm/search/binary.rb'

describe Algorithm::Search do
  subject { described_class }

  let(:integer_array) do
    (1..10).to_a
  end

  let(:float_array) do
    [1.0, 2.0, 3.0, 4.0, 5.0]
  end

  context '#iterative' do
    it 'find when element is middle' do
      subject.iterative_binary(integer_array, 5).should == 4
    end

    it 'find when element is in left side' do
      subject.iterative_binary(integer_array, 3).should == 2
    end

    it 'find when element is in right side' do
      subject.iterative_binary(integer_array, 7).should == 6
    end

    it 'find when element is last' do
      subject.iterative_binary(integer_array, 10).should == 9
    end

    it 'find when element is first' do
      subject.iterative_binary(integer_array, 1).should == 0
    end

    it 'returns nil if not found' do
      subject.iterative_binary(integer_array, 20).should == nil
    end

    it 'finds with float array as well' do
      subject.iterative_binary(float_array, 2.0).should == 1
    end
  end

  context '#iterative' do
    it 'find when element is middle' do
      subject.recursive_binary(integer_array, 5).should == 4
    end

    it 'find when element is in left side' do
      subject.recursive_binary(integer_array, 3).should == 2
    end

    it 'find when element is in right side' do
      subject.recursive_binary(integer_array, 7).should == 6
    end

    it 'find when element is last' do
      subject.recursive_binary(integer_array, 10).should == 9
    end

    it 'find when element is first' do
      subject.recursive_binary(integer_array, 1).should == 0
    end

    it 'returns nil if not found' do
      subject.recursive_binary(integer_array, 20).should == nil
    end

    it 'finds with float array as well' do
      subject.recursive_binary(float_array, 2.0).should == 1
    end
  end
end
