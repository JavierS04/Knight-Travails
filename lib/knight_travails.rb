class Node
    attr_accessor :value, :possible_moves

    def initialize(value)
        @value = value
        @possible_moves = calculate_moves
    end

    def calculate_moves
        possible_moves = []
        row, col = @value
    
        # Possible knight moves offsets
        move_offsets = [
          [-2, -1], [-2, 1], [2, -1], [2, 1],
          [-1, -2], [-1, 2], [1, -2], [1, 2]
        ]
    
        # Calculate and filter valid moves
        move_offsets.each do |(dr, dc)|
          new_row, new_col = row + dr, col + dc
          if new_row.between?(0, 7) && new_col.between?(0, 7)
            possible_moves << [new_row, new_col]
          end
        end
    
        possible_moves
      end
end

class Board 
    attr_accessor :board

    def initialize()
        @board = create_board
    end

    def create_board
        grid = Array.new(8) { Array.new(8) }
        (0...8).each do |row|
          (0...8).each do |col|
            grid[row][col] = Node.new([row, col])
          end
        end
        grid
    end
    
    def valid_move(value, move)
        node = find_node(value)
        puts node.possible_moves.inspect
        node.possible_moves.include?(move) ? "valid move" : "move not valid"
    end 

    def find_node(value)
        (0...8).each do |row|
          (0...8).each do |col|
            return @board[row][col] if @board[row][col].value == value
          end
        end
        nil # Return nil if the node is not found
    end
    
    
end


a = Board.new()
a.move([3,3],[4,1])

