# Each line originally contained a specific calibration value that the Elves
# now need to recover. On each line, the calibration value can be found by
# combining the first digit and the last digit (in that order) to form a
# single two-digit number. What is the sum of all of the calibration values?

# Digit constants

DIGITS = '123456789'
DIGITS_STRING = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']

# Digit recovery functions

def recover_digit(line)
  line.each_char do |char|
    return char if DIGITS.include?(char)
  end
end

def recover_digit_string(line, digit_array)
  string_digit, int_digit = [line.length], []

  digit_array.each_with_index do |digit, i|
    digit_index = line.index(digit)
    next if digit_index.nil?
    if digit_index < string_digit[0]
      string_digit = [digit_index, i+1]
    end
  end

  line.each_char.with_index do |char, i|
    if DIGITS.include?(char)
      int_digit = [i, char]
      break
    end
  end

  if string_digit[0] < int_digit[0]
    digit = string_digit[1]
  else
    digit = int_digit[1]
  end

  digit.to_s
end

# Recover calibration function - puzzle part 1

def calibration_recovery(line)
  first = recover_digit(line)
  last = recover_digit(line.reverse)

  first + last
end

# Recover calibration function - puzzle part 2

def calibration_recovery2(line)
  first = recover_digit_string(line, DIGITS_STRING)
  last = recover_digit_string(line.reverse, DIGITS_STRING.map(&:reverse))

  first + last
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
