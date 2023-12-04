# Part 1
# Picking one up, it looks like each card has two lists of numbers separated
# by a vertical bar (|): a list of winning numbers and then a list of numbers
# you have. You organize the information into a table (your puzzle input).
# The first match makes the card worth one point and each match after the
# first doubles the point value of that card.
# How many points are they worth in total?

# Part 2
# There's no such thing as "points". Instead, scratchcards only cause you to
# win more scratchcards equal to the number of winning numbers you have.
# Specifically, you win copies of the scratchcards below the winning card equal
# to the number of matches. So, if card 10 were to have 5 matching numbers,
# you would win one copy each of cards 11, 12, 13, 14, and 15.
# Including the original set of scratchcards, how many total scratchcards do
# you end up with?

# Read input

dir = File.join(File.dirname(__FILE__),'input.txt')
input = File.read(dir).lines.map { |line| line[10..-2] }

# Solve puzzle

score = 0
scratchcards = Array.new(input.length, 1)
input.each_with_index do |line, card_n|
  card = line.split('|')
  winners, numbers = card[0].split, card[1].split

  matches = 0
  numbers.each { |num| matches += 1 if winners.include?(num) }
  score += 2 ** (matches - 1) if matches > 0

  scratchcards[card_n].times do
    1.upto(matches) { |offset| scratchcards[card_n + offset] += 1 }
  end

end

puts "Part 1 solution is: #{score}"
puts "Part 2 solution is: #{scratchcards.sum}"
