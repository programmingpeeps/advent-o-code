def part1(input_file)
    checksum = 0
    input = File.readlines(input_file)
        .map { |line| line.chomp }
        .map { |line| line.split(' ') }
        .map { |line| line.map(&:to_i) }

    input.each do |row|
        diff = row.max - row.min
        checksum += diff
    end
    puts checksum
end

def part2(input_file)
    checksum = 0
    input = File.readlines(input_file)
        .map { |line| line.chomp }
        .map { |line| line.split(' ') }
        .map { |line| line.map(&:to_i) }

    input.each do |row|
        row.each_index do |i1|
            (i1+1..row.length-1).each do |i2|
                if (row[i1] % row[i2]) == 0 
                    checksum += row[i1] / row[i2]
                elsif (row[i2] % row[i1] == 0)
                    checksum += row[i2] / row[i1]
                end
            end
        end
    end
    puts checksum
end

if ARGV.first == "--part1"
    part1(ARGV[1])
elsif ARGV.first == "--part2"
    part2(ARGV[1])
end
