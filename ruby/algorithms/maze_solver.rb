# frozen_string_literal: true

class MazeSolver
  # Takes a `/`-delimited string containing a maze
  # $ is the starting point
  # - is an empty space
  # * is the goal
  # # is a wall
  def initialize(maze_string)
    @maze_grid = convert_to_grid(maze_string)
    @cost_grid = []
    @maze_grid.each_with_index do |row, y|
      @cost_grid[y] = []
      row.each_with_index do |cell, x|
        if cell == '#'
          @cost_grid[y][x] = Float::INFINITY
        elsif cell == '*'
          @cost_grid[y][x] = 0
          @goal = [y, x]
        elsif cell == '$'
          @start = [y, x]
        else
          @cost_grid[y][x] = nil
        end
      end
    end
  end

  # Determines the optimal route from the starting point to the finish point
  def solve(mode)
    # TODO: throw an error if start or goal is nil

    if mode == :start
      calculate_cost_from_point(@start.first, @start.last)
    else
      calculate_cost_from_goal
    end
    print_grid(@cost_grid)
  end

  private

  # Find the cost of reaching the neighbours from each tile, except the grid
  def calculate_cost_from_goal
    @queue ||= [@goal]
    until @queue.empty?
      tile = @queue.shift
      y = tile.first
      x = tile.last

      return if [y, x] == @start

      calculate_tile_cost(y, x, +1, 0)
      calculate_tile_cost(y, x, -1, 0)
      calculate_tile_cost(y, x, 0, -1)
      calculate_tile_cost(y, x, 0, +1)
    end
  end

  def calculate_tile_cost(y, x, delta_y, delta_x)
    return if y + delta_y < 0 || y + delta_y >= @height
    return if x + delta_x < 0 || x + delta_x >= @width
    return unless @cost_grid[y + delta_y][x + delta_x].nil?

    @cost_grid[y + delta_y][x + delta_x] ||= 1 + @cost_grid[y][x]

    # Because this uses BFS, we know that it reaches each tile in the shortest number of moves
    @cost_grid[y + delta_y][x + delta_x].nil?
    @queue << [y + delta_y, x + delta_x]
  end

  # Find the cost of reaching the neighbours from each tile, except the grid
  def calculate_cost_from_point(y, x)
    return Float::INFINITY if x < 0 || y < 0 || x >= @width || y >= @height
    return @cost_grid[y][x] if @cost_grid[y][x]

    @cost_grid[y][x] = Float::INFINITY # used to prevent infinite recursion

    neighbours = []
    neighbours << 1 + calculate_cost_from_point(y + 1, x) if y + 1 < @height
    neighbours << 1 + calculate_cost_from_point(y - 1, x) if y > 0
    neighbours << 1 + calculate_cost_from_point(y, x + 1) if x + 1 < @width
    neighbours << 1 + calculate_cost_from_point(y, x - 1) if x > 0

    @cost_grid[y][x] = neighbours.min
  end

  def print_grid(grid)
    grid.each do |row|
      puts row
        .map { |e| e.nil? ? '.' : e }
        .join(' ')
        .gsub(/Infinity/, '#')
    end
  end

  # Converts maze strings into equivalent 2D arrays:
  # $--#-     [[$, -, -, #, -]
  # -###- --> [-, #, #, #, -]
  # -#---     [-, #, -, -, -]
  # ---#*     [-, -, -, #, *]]
  def convert_to_grid(maze_string)
    rows = maze_string.split('/')
    grid = []
    @height = rows.length
    rows.each_with_index do |row, index|
      @width = row.length if @width.nil?
      raise(ArgumentError, 'maze is not a rectangle') if @width != row.length

      grid[index] = row.split('')
    end
    grid
  end
end

maze_1 = "$..#./.###./.#.../...#*"
maze_2 = "$.../..../..../...*"
maze_3 = "......../..##.##./..#...#./..#.#.#./..#$#.../..######/.##...*./....#..."

MazeSolver.new(maze_1).solve(:start)
puts
MazeSolver.new(maze_2).solve(:start)
puts
MazeSolver.new(maze_3).solve(:start)
puts '---'
MazeSolver.new(maze_1).solve(:goal)
puts
MazeSolver.new(maze_2).solve(:goal)
puts
MazeSolver.new(maze_3).solve(:goal)

# rubocop:disable Style/BlockComments
=begin
$..#.
.###.
.#...
...#*
=end

=begin
$...
....
....
...*
=end

=begin
........
..##.##.
..#...#.
..#.#.#.
..#$#...
..######
.##...*.
....#...
=end
