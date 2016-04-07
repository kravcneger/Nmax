module Nmax
  class PqError < StandardError; end

  class Pq
    def initialize(size)
      raise Nmax::PqError unless size.is_a?(Numeric) && size > 0

      @nodes = [0]
      @size = size.to_i
    end
    
    def insert(number)
      if crowded? && number > min
        del_min
      end
      
      unless crowded?
        if @nodes[1] 
          @nodes.push(number)
          swim(count_elements)
        else
          @nodes[1] = number
        end
      end
    end

    alias_method :<<, :insert

    def max_size
      @size
    end

    def count_elements
      @nodes.count - 1
    end

    def del_min
      min = self.min
      exch(1, count_elements)
      @nodes.pop
      sink(1)
      min
    end

    def min
      @nodes[1]
    end
    
    def to_array
      @nodes[1..-1]
    end

    def to_s
      @nodes[1..-1].to_s
    end

    private

    def less(i, j)
      @nodes[i] > @nodes[j]
    end

    def exch(i, j)
      t = @nodes[i]
      @nodes[i] = @nodes[j]
      @nodes[j] = t
    end

    def swim(k)
      while k > 1 && less( (k/2).to_i , k)
        exch( (k/2).to_i , k)
        k = (k/2).to_i
      end
    end

    def sink(k)
      while 2*k <= count_elements
        j = 2*k

        j += 1 if j < count_elements && less(j, j+1)
        break unless less(k, j)

        exch(k ,j)
        k = j
      end
    end

    def crowded?
      max_size <= count_elements
    end

  end
end