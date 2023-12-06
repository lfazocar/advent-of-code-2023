# Read input

dir = File.join(File.dirname(__FILE__),'input.txt')
input = File.read(dir).delete("^:1234567890 \n")[1..-1].split(':')

seeds = input.shift.split.map(&:to_i)

map_list = input.map { |text|
  text[1...-1].split("\n").map{ |line| line.split.map(&:to_i) }
}

# Solve puzzle

# Convert source to destination function
# Destination range upper limit is required for part 2

def map_destination(source, map, limit = false)
  destination = [source] # [source, upper limit]

  map.each do |map_data|
    destination_start = map_data[0]
    source_start = map_data[1]
    range = map_data[2]

    if source.between?(source_start, source_start + range)
      destination[0] += destination_start - source_start

      if limit
        if destination_start - source_start > 0
          destination.push(destination_start + range)
        end

      end

      break
    end

  end
  destination
end

# Iterate recursively through the maps

def iterate_maps(seed_array, map_list, limit = false)
  return seed_array if map_list.empty?
  mapped = []

  map = map_list.shift
  seed_array.each do |seed|
    mapped += map_destination(seed, map, limit)
  end

  iterate_maps(mapped.uniq, map_list, limit)
end

puts "Part 1 solution is: #{iterate_maps(seeds.dup, map_list.dup).min}"

seed_ranges = []
0.step(seeds.length-1, 2) { # Only need start and end of seed range
  |i| seed_ranges.push(seeds[i], seeds[i] + seeds[i+1] - 1)
}

puts "Part 2 solution is: #{iterate_maps(seed_ranges, map_list, true).min}"
