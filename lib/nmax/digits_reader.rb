module Nmax
  class DigitsReader
    
    def self.read(stream, count)

      pq = Nmax::Pq.new(count)

      last_digits_line = ''
      first_digits_line = ''

      stream.each_line do |line|
        first_digits_line = first_digits(line)
        current_last_digits_line = last_digits(line)
        
        unless string_is_number?(line) 

          unless (numbers = line.scan(/(\d{1,1000})/)).empty?
            numbers.shift if first_digits_line != ''
            numbers.pop if current_last_digits_line != ''

            numbers.each do |e|
              pq << e.first.to_i
            end
          end

          if last_digits_line != ''
            if first_digits_line != ''
              pq << (last_digits_line + first_digits_line).to_i
            else              
              pq << last_digits_line.to_i
            end
          else
            if first_digits_line != ''              
              pq << first_digits_line.to_i
            end
          end

          last_digits_line = current_last_digits_line.clone
        else
          last_digits_line = last_digits_line + line.strip
        end
      end
      pq << last_digits_line.to_i if last_digits_line != ''
      
      pq.to_array
    end

    def self.first_digits(str)
      if numbers = /^(\d{1,1000})/.match(str)
        return numbers.to_a[1]
      end
      ''
    end

    def self.last_digits(str)
      if numbers = /(\d{1,1000})$/.match(str)
        return numbers.to_a.last
      end
      ''
    end

    def self.string_is_number?(str)
       /^(\d{1,1000})$/.match(str) ? true : false
    end


  end
end