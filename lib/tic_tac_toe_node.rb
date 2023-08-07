require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    # board.over? 
    # winner == opponent (LOSING NODE)
    # winner == nil || player (NOT LOSING NODE)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    mark = switch_mark
    moves = []
    (0...@board.length).each do |i|
      (0...@board.length).each do |j|
        duped = @board.dup

        if @board.empty([i,j]) # true if nil/empty
          # game state of other player
          moves << TicTacToeNode.new(duped, mark, [i,j])
          # other players mark
          duped[i,j]=next_mover_mark
        end
        
      end
    end
    moves
  end

  def switch_mark
    next_mover_mark == :o ? :x : :o
  end

end