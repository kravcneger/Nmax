require 'nmax/version'
require 'nmax/pq'
require 'nmax/digits_reader'

module Nmax

  def self.read(stream, count)
    DigitsReader.read(stream, count).sort
  end

end
