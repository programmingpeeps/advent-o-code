def balance_baybee(banks)
  max = banks.max
  max_index = banks.find_index { |i| i == max }

  total = banks[max_index]
  banks[max_index] = 0
  max_index += 1

  while total > 0 do
    max_index = 0 if max_index > banks.length - 1

    banks[max_index] += 1

    max_index += 1
    total -= 1
  end

  banks
end

def where_in_history(history, banks)
  joined = banks.join(',')
  history.find_index { |x| x == joined }
end

def main
  #banks = [0, 2, 7, 0]
  banks = [11,11,13,7,0,15,5,5,4,4,1,1,7,1,15,11]

  history = []

  rebalance = []
  steps = 0
  repeated_in = 0
  loop do
    rebalance = balance_baybee(banks) 
    steps += 1
    found_index = where_in_history(history, rebalance)
    unless found_index.nil?
      puts steps - found_index - 1
      break
    end
    history << rebalance.join(',')
  end
end

main