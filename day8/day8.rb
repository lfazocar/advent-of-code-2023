# Read input

dir = File.join(File.dirname(__FILE__),'input.txt')
input = File.read(dir).delete("^A-Z \n").lines(chomp: true).reject(&:empty?)

instructions = input.shift.gsub(/[LR]/) { |char| char == 'L' ? 0 : 1 }.
               split('').map(&:to_i)

network = Hash.new
input.map(&:split).each do |node|
  node.map!(&:to_sym)
  network[node[0]] = [node[1], node[2]]
end

# Solve puzzle - part 1

def network_travel(network, instructions, start)
  current_node, steps = start, 0

  until current_node.end_with?('Z')
    next_step = steps % instructions.length
    next_instruction = instructions[next_step]
    current_node = network[current_node][next_instruction]
    steps +=1
  end

  steps
end

puts "Part 1 solution is: #{network_travel(network, instructions, :AAA)}"

# Solve puzzle - part 2

def least_common_multiple(num1, num2)
  mult1, mult2 = 1, 1
  until num1 * mult1 == num2 * mult2
    num1 * mult1 < num2 * mult2 ? mult1 += 1 : mult2 += 1
  end
  num1 * mult1
end

start_nodes = network.keys.select { |node| node.end_with?('A') }

az_steps = []
start_nodes.each { |node| az_steps.push(network_travel(network, instructions, node)) }

az_step_lcm = az_steps.reduce { |a, b| least_common_multiple(a, b) }

puts "Part 2 solution is: #{az_step_lcm}"
