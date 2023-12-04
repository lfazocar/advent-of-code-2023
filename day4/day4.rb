# Picking one up, it looks like each card has two lists of numbers separated
# by a vertical bar (|): a list of winning numbers and then a list of numbers
# you have. You organize the information into a table (your puzzle input).
# The first match makes the card worth one point and each match after the
# first doubles the point value of that card.
# How many points are they worth in total?

# Read input

dir = File.join(File.dirname(__FILE__),'input.txt')
input = File.read(dir).lines.map { |line| line[10..-2] }

# Solve puzzle - part 1

score = 0
input.each do |line|
  card = line.split('|')
  winners = card[0].split
  numbers = card[1].split
  matches = 0
  numbers.each do |num|
    matches += 1 if winners.include?(num)
  end
  score += 2 ** (matches - 1) if matches > 0
end

puts "Part 1 solution is: #{score}"
