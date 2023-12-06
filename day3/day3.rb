# There are lots of numbers and symbols you don't really understand, but
# apparently any number adjacent to a symbol, even diagonally, is a "part
# number" and should be included in your sum. (Periods (.) do not count as a
# symbol.)
# What is the sum of all of the part numbers in the engine schematic?

# Part 2
# A gear is any * symbol that is adjacent to exactly two part numbers. Its gear
# ratio is the result of multiplying those two numbers together. This time, you
# need to find the gear ratio of every gear and add them all up so that the
# engineer can figure out which gear needs to be replaced.

# Read input

dir = File.join(File.dirname(__FILE__),'input.txt')
input = File.read(dir).lines

# Valid positions function

def adjacent_positions(symbols)
  positions = []
  line_i = symbols[0]
  char_i = symbols[1]
  1.downto(-1) do |x|
    1.downto(-1) do |y|
      next if x == 0 && y == 0
      positions.push([line_i - y, char_i - x])
    end
  end
  positions
end

# Find symbols and numbers

numbers = []  # [number, [array of [line, index]]]
symbols = [] # [symbol, [line, index]]
input.each_index do |line_i|
  num = ''

  input[line_i].each_char.with_index do |char, char_i|

    if ('0'..'9').include?(char)
      num += char
    else

      unless num.empty?
        num_pos = []
        1.upto(num.length) do |num_i|
          num_pos.push([line_i, char_i - num_i])
        end
        numbers.push([num.to_i, num_pos])
        num = ''
      end

      symbols.push([char, [line_i, char_i]]) if char != '.' && char != "\n"
    end
  end
end

# Solve puzzle

part_sum, gear_sum = 0, 0
symbols.each do |symbol|
  valid_pos = adjacent_positions(symbol[1])
  gear = symbol[0] == '*'

  added_parts = []
  ratio, first, first_pos = 0, 0, []
  valid_pos.each do |pos|

    numbers.each do |number|
      value = number[0]
      number_pos = number[1]

      if number_pos.include?(pos)

        # Part 1
        unless added_parts.intersect?(number_pos)
          part_sum += value
          added_parts += number_pos
        end

        # Part 2
        if gear && number_pos != first_pos
          if first == 0
            first = value
            first_pos = number_pos
          else
            ratio += first * value
            break
          end
        end

      end
    end

    if gear && ratio != 0
      gear_sum += ratio
      ratio = 0
      break
    end

  end
end

puts "Part 1 solution is: #{part_sum}"
puts "Part 2 solution is: #{gear_sum}"
