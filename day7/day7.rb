# In Camel Cards, you get a list of hands, and your goal is to order them based
# on the strength of each hand. A hand consists of five cards labeled one of A,
# K, Q, J, T, 9, 8, 7, 6, 5, 4, 3, or 2. The relative strength of each card
# follows this order, where A is the highest and 2 is the lowest.

# Every hand is exactly one type. From strongest to weakest, they are:
# Five of a kind, where all five cards have the same label: AAAAA
# Four of a kind, where four cards have the same label and one card has a
# different label: AA8AA
# Full house, where three cards have the same label, and the remaining two
# cards share a different label: 23332
# Three of a kind, where three cards have the same label, and the remaining two
# cards are each different from any other card in the hand: TTT98
# Two pair, where two cards share one label, two other cards share a second
# label, and the remaining card has a third label: 23432
# One pair, where two cards share one label, and the other three cards have a
# different label from the pair and each other: A23A4
# High card, where all cards' labels are distinct: 23456

# Hands are primarily ordered based on type; for example, every full house is
# stronger than any three of a kind.
# If two hands have the same type, a second ordering rule takes effect. Start
# by comparing the first card in each hand. If these cards are different, the
# hand with the stronger first card is considered stronger. If the first card
# in each hand have the same label, however, then move on to considering the
# second card in each hand. If they differ, the hand with the higher second
# card wins; otherwise, continue with the third card in each hand, then the
# fourth, then the fifth.

# To play Camel Cards, you are given a list of hands and their corresponding bid
# (your puzzle input). Each hand wins an amount equal to its bid multiplied by
# its rank, where the weakest hand gets rank 1, the second-weakest hand gets
# rank 2, and so on up to the strongest hand. You can determine the total
# winnings of this set of hands by adding up the result of multiplying each
# hand's bid with its rank.

# Card labels constant

LABELS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]

# Read input

dir = File.join(File.dirname(__FILE__),'input.txt')
input = File.read(dir).lines.map(&:split)

# Base 13 to determine hand strength

def hand_strength(hand)
  strength = 0

  hand.reverse.each_char.with_index do |label, i|
    strength += 13 ** i * LABELS.index(label)
  end

  strength
end

# Determine hand type

def hand_type(hand)
  cards = Hash.new
  type = 0

  hand.each_char do |card|
    unless cards.has_key?(card)
      card_count = hand.count(card)
      cards[card.to_sym] = card_count
    end
  end

  cards.each_value do |count|
    case count
    when 5 # Five of a kind = 6
      type = 6
    when 4 # Four of a kind = 5
      type = 5
    when 3 # 3 of a kind = 3 | Full house = 4
      type += 3
    when 2 # One pair = 1 | Two pairs = 2
      type += 1
    end
  end

  type
end

# Solve puzzle - part 1

games = input

games_by_type = Array.new(7) { Array.new }
games.each do |game|
  hand, bid = game

  type = hand_type(hand)
  strength = hand_strength(hand)

  games_by_type[type].push({bid: bid.to_i, strength: strength})
end

ranked_bids = games_by_type.
              flat_map { |type| type.sort_by { |game| game[:strength] } }.
              map { |game| game[:bid] }

winnings = 0
ranked_bids.each_with_index do |bid, rank|
  rank += 1
  winnings += bid * rank
end

puts "Part 1 solution is: #{winnings}"
