def calc(state, coord)
  transformations = 
    [[-1, 1], [-1, 0], [-1, -1], [0, -1], [0, 1],
    [1, 1], [1, 0], [1, -1]]

  new_num = transformations.reduce(0) do |sum, n|
      x_coord = n[0] + coord.x
      y_coord = n[1] + coord.y
      sum + state.fetch("#{x_coord},#{y_coord}", 0)
    end

  puts new_num
  state["#{coord.x},#{coord.y}"] = new_num
  state
end

class Coord
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def up
    @y += 1
    self
  end

  def down
    @y -= 1
    self
  end

  def left
    @x -= 1
    self
  end

  def right
    @x += 1
    self
  end
end

def generate_spiral
  side_length = 3

  highest_num = 1
  state = {"0,0" => 1}
  coord = Coord.new(0,0)

  while highest_num <= 265149 do
    length = side_length - 1
    state = calc(state, coord.right)
    (length - 1).times do 
      state = calc(state, coord.up)
    end
    length.times do 
      state = calc(state, coord.left)
    end
    length.times do 
      state = calc(state, coord.down)
    end
    length.times do 
      state = calc(state, coord.right)
    end

    side_length += 2
    highest_num = state["#{coord.x},#{coord.y}"]
  end

end

generate_spiral

# init at 0,0
# first move is x + 1
  # 1,0
# go up side_length - 1
  # 1,1
# go left side_length - 1
  # 0,1
  # -1,1
# go down side_length - 1
  # -1,0
  # -1,-1
# go right side_length - 1
  # 0,-1
  # 1,-1
# side_length += 2
=begin
  0,0
  1,0
  1,1
  0,1
  -1,1
  -1,0
  -1,-1  
  0,-1
  1,-1
  2,-1
  2,0
  2,1
  2,2
  1,2
  0,2  
=end