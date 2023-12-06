# Read input

dir = File.join(File.dirname(__FILE__),'input.txt')
input = File.read(dir).delete("^:1234567890 \n")[1..-1].split(':')

seeds = input.shift.split.map(&:to_i)

map_list = input.map { |text|
  text[1..-2].split("\n").map{ |line| line.split.map(&:to_i) }
}

# Map destination function

def map_destination(source, map)
  destination = source
  map.each do |map_array|
    source_range = (map_array[1]...map_array[1] + map_array[2])
    if source_range.include?(source)
      destination = map_array[0] + source - map_array[1]
      break
    end
  end
  destination
end

# Solve puzzle - part 1

def iterate_maps(seed_array, map_list)
  return seed_array if map_list.empty?

  map = map_list.shift
  seed_array.map! { |seed| map_destination(seed, map) }

  iterate_maps(seed_array, map_list)
end

iterate_maps(seeds, map_list)

puts "Part 1 solution is: #{seeds.min}"
