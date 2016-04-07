require 'spec_helper'

RSpec.describe Nmax::Pq do
  let(:pq){ Nmax::Pq.new(3) }
  
  it "should to keep the queue size" do
    pq.insert(1)
    pq.insert(2)
    pq.insert(3)
    pq.insert(4)
    pq.insert(5)
    pq.insert(6)
    
    expect(pq.count_elements).to eq(3)
  end

  it "incorrect size" do
    expect { Nmax::Pq.new(0) }.to raise_error(Nmax::PqError)
    expect { Nmax::Pq.new('') }.to raise_error(Nmax::PqError)
  end

  it "#del_min" do
    expect(pq.del_min).to eq(nil)
    pq.insert(2)
    pq.insert(4)
    pq.insert(1)
    pq.insert(6)

    expect(pq.del_min).to eq(2)
    expect(pq.del_min).to eq(4)
    expect(pq.del_min).to eq(6)
  end

  it "#count_elements and #insert" do
    expect{pq.insert(2);pq.insert(4)}.to change{pq.count_elements}.from(0).to(2)
  end
  

end