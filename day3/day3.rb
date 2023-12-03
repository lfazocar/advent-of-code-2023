# There are lots of numbers and symbols you don't really understand, but
# apparently any number adjacent to a symbol, even diagonally, is a "part
# number" and should be included in your sum. (Periods (.) do not count as a
# symbol.)
# What is the sum of all of the part numbers in the engine schematic?

# Read input

dir = File.join(File.dirname(__FILE__),'input.txt')
input = File.read(dir).lines

# Valid positions function

def valid_positions(symbol_pos)
  positions = []
  line = symbol_pos[0]
  index = symbol_pos[1]
  1.downto(-1) do |x|
    1.downto(-1) do |y|
      next if x == 0 && y == 0
      unless line - y < 0 || index - x < 0 || line - y > 140 || index - x > 140
        positions.push([line - y, index - x])
      end
    end
  end
  positions
end

# Find symbols and numbers

symbols_pos = [] # [[line, index]]
numbers = []  # [number, [[line, index]]]
(0...input.length).each do |line_i|
  num = ''
  input[line_i].each_char.with_index do |char, char_i|
    if ('0'..'9').include?(char)
      num += char
    else
      unless num.empty?
        num_pos = []
        (1..num.length).each do |n|
          num_pos.push([line_i, char_i - n])
        end
        numbers.push([num.to_i, num_pos])
        num = ''
      end
      symbols_pos.push([line_i, char_i]) if char != '.' && char != "\n"
    end
  end
end

# Solve puzzle - part 1

valid_pos = []
symbols_pos.each do |pos|
  valid_pos += valid_positions(pos)
end

sum = 0
numbers.each do |number|
  value = number[0]
  number[1].each do |pos|
    if valid_pos.include?(pos)
      sum += value
      break
    end
  end
end

puts "Part 1 solution is: #{sum}"
