require_relative '../poly_tree_node/lib/00_tree_node.rb'

class KnightPathFinder 
  BOARD_COORDINATES = (0..7).to_a.permutation(2).to_a + (0..7).to_a.map { |el| [el,el] }
  MOVES = array = [1, -1, 2, -2].permutation(2).to_a.reject { |arr| arr[0] + arr[1] == 0 }
  
  attr_reader :queue
  
  def initialize(start_pos)
    @start_pos = start_pos
    @current_pos = start_pos
    @visited_positions = [start_pos]
  end
  
  def self.valid_moves(pos)
    # array = [1, -1, 2, -2].permutation(2).to_a.reject do |arr|
    #   arr[0] + arr[1] == 0
    # end
    
    MOVES.map do |arr|
      [pos[0]+arr[0], pos[1]+arr[1]]
    end
  end
  
  def build_move_tree    
    queue = [PolyTreeNode.new(@start_pos)]
    
    until queue.empty?
      node = queue.shift
      possible_moves = new_move_positions(node.value)
      possible_moves.each do |pos|
        @visited_positions << pos
        child_node = PolyTreeNode.new(pos)
        child_node.parent = node
        queue << child_node
      end
    end 
    
    @queue = queue
  end
  
  def find_path(goal_pos)
    
  end
  
  def new_move_positions(pos)
    self.class.valid_moves(pos).reject do |arr|
      @visited_positions.include?(arr) && !on_board?(arr)
    end
  end
  
  def on_board?(pos)
    BOARD_COORDINATES.include?(pos)
  end
end