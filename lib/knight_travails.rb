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

      def get_pm
        return @possible_moves
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
    
    # def valid_move(value, move)
    #     node = find_node(value)
    #     puts node.possible_moves.inspect
    #     node.possible_moves.include?(move) ? "valid move" : "move not valid"
    # end 

    def find_node(value)
        (0...8).each do |row|
          (0...8).each do |col|
            return @board[row][col] if @board[row][col].value == value
          end
        end
        nil # Return nil if the node is not found
    end
    
    def move (start_point, end_point)
        return p "invalid position entered" if !find_node(start_point) || !find_node(end_point)

        queue = [find_node(start_point)]
        parents = []
        found = false

        while found == false
          node = queue.shift

          if node == nil
          elsif node.value == end_point
            found = true
          else 
              parents << node unless parents.include?(node)
          end

          node.get_pm.each do |possible|
            queue << find_node(possible) unless queue.include?(possible)
          end
        end

        correct_list = []
        current = end_point
        until found == false
          previous = parents.pop
                    
          if previous == nil
            found = false
            break
          end

          if previous.possible_moves.include?(current)
            correct_list << previous.value
            current = previous.value
          end
        end

        correct_list = correct_list.reverse
        correct_list << end_point
        puts "You made it in #{correct_list.length - 1}. Here's the path: "
        puts correct_list.inspect
    end
end


a = Board.new()
a.move([-3,-3],[3,3])

