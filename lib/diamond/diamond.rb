class Diamond
  class << self
    def make_diamond(letter)
      letters = ('A'..letter).to_a

      join_diamond(letters)
    end

    private

    def join_diamond(letters)
      top_diamond = create_top(letters)
      bottom_diamond = top_diamond.clone.reverse.drop(1)

      (top_diamond + bottom_diamond).join
    end

    def create_top(letters)
      line_size = (letters.length * 2) - 1

      Array.new(letters.length) do |x|
        new_line = Array.new(line_size) do |y|
          left_pointer = letters.length - 1 - x
          rigth_pointer = letters.length - 1 + x

          if y == left_pointer || y == rigth_pointer
            letters[x]
          else
            ' '
          end
        end

        "#{new_line.join}\n"
      end
    end
  end
end
