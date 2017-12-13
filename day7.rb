class Entry
  REGEX = /(\w+) \((\d+)\) -> (.*)/
  NO_CHILDREN_REGEX = /(\w+) \((\d+)\)/

  attr_reader :name, :weight, :children
  attr_accessor :child_weight, :entry_children

  def initialize(entry)
    @child_weight = 0
    @entry_children = []
    parse_entry(entry)
  end

  def parse_entry(entry)
    children = []
    name = ''
    weight = 0

    if REGEX.match?(entry)
      name, weight, raw_children = REGEX.match(entry).captures
      children = raw_children.split(', ')
    else
      name, weight = NO_CHILDREN_REGEX.match(entry).captures
    end

    @name = name
    @weight = weight.to_i
    @children = children
  end

  def sum_weights
    if @entry_children.length == 0
      @weight
    else
      @entry_children.reduce(@weight) { |acc, c| acc + c.sum_weights }
    end
  end
end

# we'll see all the children as "NO_CHILDREN"
# we found the bottom when we find the entry with children that isn't a child
# of another list

# first list is all children of all the entries
# second list is all entries with children
# bottom one is where it has children but isn't in first list

def main
  entries = File.readlines('day7.txt')

  all_entries = entries.map { |e| Entry.new(e) }
  all_children = all_entries.map { |e| e.children }.flatten
  with_children = 
    all_entries
      .select { |e| e.children.length > 0 }
      .map { |e| e.name }

  bottom = all_entries.select do |e| 
    # not in all_children but in with_children }
    in_children = all_children.include?(e.name)
    has_children = with_children.include?(e.name)
    !in_children and has_children
  end.first

  return bottom
end

def main_part2
  entries = File.readlines('day7.txt')

  all_entries = entries.map { |e| Entry.new(e) }

  entry_map = {}
  all_entries.each do |e|
    entry_map[e.name] = e
  end
  
  all_entries.each do |e|
    e.children.each do |c|
      e.entry_children << entry_map[c]
    end

    child_weight = e.children.reduce(0) do |acc, c| 
      acc + entry_map[c].weight
    end
    e.child_weight = child_weight
  end

  with_children = 
    all_entries
      .select { |e| e.children.length > 0 }

  x = with_children.each do |e|
    child_weights = e.children.map { |c| entry_map[c].sum_weights }
    weights_with_children = e.children.map { |c| entry_map[c].sum_weights }.uniq
    if weights_with_children.length > 1
      puts "#{e.name} #{e.weight} children: #{e.entry_children.map { |c| "#{c.name} #{c.weight}"}}"
      puts "#{child_weights}"
    end
  end
  puts "end"
end

main_part2