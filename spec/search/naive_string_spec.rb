require 'spec_helper'
require 'algorithm/search/naive_string.rb'

describe Algorithm::Search do
  subject { described_class }

  it 'finds when pattern when is first' do
    subject.naive_search('ABCDEF', 'A').should == 0
  end

  it 'finds when pattern when is middle' do
    subject.naive_search('ABCDEF', 'D').should == 3
  end

  it 'finds when pattern when is last' do
    subject.naive_search('ABCDEF', 'F').should == 5
  end

  it 'returns nil when pattern is not found' do
    subject.naive_search('ABCDEF', 'AF').should == nil
  end

  it 'returns index of first matched pattern to last matched pattern' do
    subject.naive_search('ABCDEF', 'BC').should == [1,2]
  end

  it 'returns index of first matched pattern to last matched pattern' do
    subject.naive_search('ABCDEF', 'BCD').should == [1,3]
  end

  it 'returns index of first matched pattern to last matched pattern' do
    subject.naive_search('ABCDEF', 'BCDE').should == [1,4]
  end
end
