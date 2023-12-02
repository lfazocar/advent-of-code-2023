# Determine which games would have been possible if the bag had been loaded
# with only 12 red cubes, 13 green cubes, and 14 blue cubes. What is the
# sum of the IDs of those games?
# Part 2:
# The power of a set of cubes is equal to the numbers of red, green, and blue
# cubes multiplied together. For each game, find the minimum set of cubes that
# must have been present. What is the sum of the power of these sets?

# Constants for number of cubes of each color

RED = 12
GREEN = 13
BLUE = 14

# Read input

dir = File.join(File.dirname(__FILE__),'input.txt')
input = File.read(dir).delete(":,;").lines

# Solve puzzle

id_sum, power_sum = 0, 0
input.each do |line|
  valid = true
  min_red, min_green, min_blue = 0, 0, 0
  game = line.split
  game_id = game[1].to_i
  (2...game.length).step(2).each do |i|
    cube_amount = game[i].to_i
    color = game[i+1]
    case color
    when 'red'
      min_red = cube_amount if cube_amount > min_red
      valid = false if cube_amount > RED
    when 'green'
      min_green = cube_amount if cube_amount > min_green
      valid = false if cube_amount > GREEN
    when 'blue'
      min_blue = cube_amount if cube_amount > min_blue
      valid = false if cube_amount > BLUE
    end
  end
  id_sum += game_id if valid
  power_sum += min_red * min_green * min_blue
end

puts "Part 1 solution is: #{id_sum}"
puts "Part 2 solution is: #{power_sum}"
