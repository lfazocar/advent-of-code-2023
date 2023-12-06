# As part of signing up, you get a sheet of paper (your puzzle input) that
# lists the time allowed for each race and also the best distance ever
# recorded in that race. To guarantee you win the grand prize, you need
# to make sure you go farther in each race than the current record holder.
# Holding down the button charges the boat
# and releasing the button allows the boat to move.
# For each whole millisecond you spend at the beginning of the race holding
# down the button, the boat's speed increases by one millimeter per millisecond.
# Determine the number of ways you could beat the record in each race.
# What do you get if you multiply these numbers together?

# Read input

dir = File.join(File.dirname(__FILE__),'input.txt')
input = File.read(dir).delete("^1234567890 \n").lines.map(&:split)

def race_wins(race)
  time, record = race[0].to_i, race[1].to_i

  wins = 0
  0.upto(time/2) do |speed|
    distance = speed * (time - speed)
    wins += 1 if distance > record
  end

  if time.odd?
    wins *= 2
  else
    wins *= 2
    wins -= 1
  end
end

# Solve puzzle - part 1

wins_multiplied = 1
input[0].each_index do |i|
  wins_multiplied *= race_wins([input[0][i], input[1][i]])
end

puts "Part 1 solution is: #{wins_multiplied}"

# There's really only one race - ignore the spaces between the numbers on each line.
# How many ways can you beat the record in this one much longer race?

# Solve puzzle - part 2

long_race = input.map(&:join)

puts "Part 2 solution is: #{race_wins(long_race)}"
