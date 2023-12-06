# There are lots of numbers and symbols you don't really understand, but
# apparently any number adjacent to a symbol, even diagonally, is a "part
# number" and should be included in your sum. (Periods (.) do not count as a
# symbol.)
# What is the sum of all of the part numbers in the engine schematic?

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

symbols = [] # [[line, index]]
gears = [] # [[line, index]]
numbers = []  # [number, [[line, index]]]
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
      gears.push([line_i, char_i]) if char == '*'
      symbols.push([line_i, char_i]) if char != '.' && char != "\n"
    end
  end
end

# Solve puzzle - part 1

valid_pos = []
symbols.each do |pos|
  valid_pos += adjacent_positions(pos)
end

part_sum = 0
numbers.each do |number|
  value = number[0]
  number[1].each do |pos|
    if valid_pos.include?(pos)
      part_sum += value
      break
    end
  end
end

puts "Part 1 solution is: #{part_sum}"

# A gear is any * symbol that is adjacent to exactly two part numbers. Its gear
# ratio is the result of multiplying those two numbers together. This time, you
# need to find the gear ratio of every gear and add them all up so that the
# engineer can figure out which gear needs to be replaced.

# Solve puzzle - part 2

gear_sum = 0
gears.each do |gear|
  ratio_pos = adjacent_positions(gear)

  ratio, first, first_pos = 0, 0, []
  ratio_pos.each do |pos|

    numbers.each do |number|
    # [0] = value, [1] = positions array
      if number[1].include?(pos) && number[1] != first_pos
        if first == 0
          first = number[0]
          first_pos = number[1]
        else
          ratio += first * number[0]
          break
        end
      end
    end

    if ratio != 0
      gear_sum += ratio
      ratio = 0
      break
    end

  end
end

puts "Part 2 solution is: #{gear_sum}"
