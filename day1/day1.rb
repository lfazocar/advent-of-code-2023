# Each line originally contained a specific calibration value that the Elves now need to recover.
# On each line, the calibration value can be found by combining the first digit and the last digit (in that order) to form a single two-digit number.
# What is the sum of all of the calibration values?

# Recover calibration function - part 1

Digits = '123456789'
def calibration_recovery(line)
  first, last = '', ''

  # Recover first digit
  line.each_char do |char|
    if Digits.include?(char)
      first = char
      break
    end
  end

  # Recover last digit
  line.reverse.each_char do |char|
    if Digits.include?(char)
      last = char
      break
    end
  end

  first + last
end

# Recover calibration function - part 2

DigitsString = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
DigitsStringReversed = ["eno", "owt", "eerht", "ruof", "evif", "xis", "neves", "thgie", "enin"]
def calibration_recovery2(line)
  first, last = '', ''
  string_digit, int_digit = [line.length], []

  # Recover first digit
  DigitsString.each_with_index do |digit, i|
    digit_index = line.index(digit)
    if digit_index.nil? then next end
    if digit_index < string_digit[0]
      string_digit = [digit_index, i+1]
    end
  end

  line.each_char.with_index do |char, i|
    if Digits.include?(char)
      int_digit = [i, char]
      break
    end
  end

  if string_digit[0] < int_digit[0]
    first = string_digit[1]
  else
    first = int_digit[1]
  end

  # Recover last digit
  string_digit = [line.length]
  DigitsStringReversed.each_with_index do |digit, i|
    digit_index = line.reverse.index(digit)
    if digit_index.nil? then next end
    if digit_index < string_digit[0]
      string_digit = [digit_index, i+1]
    end
  end

  line.reverse.each_char.with_index do |char, i|
    if Digits.include?(char)
      int_digit = [i, char]
      break
    end
  end

  if string_digit[0] < int_digit[0]
    last = string_digit[1]
  else
    last = int_digit[1]
  end

  first.to_s + last.to_s
end

# Read input
dir = File.join(File.dirname(__FILE__),'input.txt')
input = File.read(dir).split

# Solve puzzle part 1
sum = 0
input.each do |line|
  sum += calibration_recovery(line).to_i
end
puts "Part 1 solution is: #{sum}"

# Solve puzzle part 2
sum = 0
input.each do |line|
  sum += calibration_recovery2(line).to_i
end
puts "Part 2 solution is: #{sum}"
