require 'spec_helper'

RSpec.describe Nmax::DigitsReader do
  describe "#read" do

      let(:stream){
        'text111text , second_number-1111 texttexttext D fourth=1 text 22' +
        '22 text' + 
        '33 text333' +
        '4' +
        '55'
      }

    it "stream" do
      expect(Nmax::DigitsReader::read(stream, 6).sort).to eq([111, 1111, 1 , 2222, 33, 333455].sort)
    end

    it "stream_one_line" do
      expect(Nmax::DigitsReader::read('111pp222 333', 2).sort).to eq([222, 333])
    end

    it "stream_full_number" do
      expect(Nmax::DigitsReader::read('11111', 2).sort).to eq([11111])
    end

  end

  it "#first_digits" do
    expect(Nmax::DigitsReader::first_digits('')).to eq('')
    expect(Nmax::DigitsReader::first_digits('11text22')).to eq('11')
    expect(Nmax::DigitsReader::first_digits('1122')).to eq('1122')
  end

  it "#last_digits" do
    expect(Nmax::DigitsReader::last_digits('')).to eq('')
    expect(Nmax::DigitsReader::last_digits('11text22')).to eq('22')
    expect(Nmax::DigitsReader::last_digits('1122')).to eq('1122')
  end

  it "#string_is_number?" do
    expect(Nmax::DigitsReader::string_is_number?('')).to eq(false)
    expect(Nmax::DigitsReader::string_is_number?('11a11')).to eq(false)
    expect(Nmax::DigitsReader::string_is_number?('a1111a')).to eq(false)
    expect(Nmax::DigitsReader::string_is_number?('1111')).to eq(true)
    expect(Nmax::DigitsReader::string_is_number?('55')).to eq(true)
  end

end