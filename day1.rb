# "1122" => 3

def part1(input)
    sum = 0
    input.split('').each_index do |i|
        next_i = i+1
        if next_i > input.length-1
            next_i = 0
        end

        if input[i] == input[next_i]
            sum += input[i].to_i
        end
    end
    puts sum
end

# 1212 => 6

# 1212
# 1

# i = 0
# 1212  --  4 / 2 + 0 = 2
# sum = 1

# i = 1
# 1212  --  4 / 2 + 1 = 2 + 1
# 0123
# sum = 1 + 2 = 2

# i = 2
# 1212  --  4 / 2 + 2 = 2 + 2
# 0123x
#   .. 0

# i = 3
#   .. 1
def part2(input)
    sum = 0
    input.split('').each_index do |i|
        next_i = (input.length / 2) + i
        if next_i > input.length-1
            next_i -= input.length
        end

        if input[i] == input[next_i]
            sum += input[i].to_i
        end
    end
    puts sum
end

if ARGV.first == "--part1"
    part1(ARGV[1])
elsif ARGV.first == "--part2"
    part2(ARGV[1])
end
