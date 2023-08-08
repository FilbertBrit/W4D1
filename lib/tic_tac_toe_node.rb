require_relative 'tic_tac_toe'


class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator) # evaluator: mark
    if @board.over?
      if (@board.winner == evaluator) || (@board.tied?)
        return false
      else
        return true
      end
    end
   
    if evaluator == next_mover_mark
      self.children.all? do |child|
        child.losing_node?(evaluator)
      end
    else
      self.children.any? do |child|
        child.losing_node?(evaluator)
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      if (@board.winner != evaluator) || (@board.tied?)
        return false
      else
        return true
      end
    end

    if evaluator == next_mover_mark
      self.children.all? do |child|
        child.winning_node?(evaluator)
      end
    else
      self.children.any? do |child|
        child.winning_node?(evaluator)
      end
    end

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    mark = switch_mark
    moves = []
    (0...@board.rows.length).each do |i|
      (0...@board.rows.length).each do |j|
        duped = @board.dup

        if @board.empty?([i,j]) # true if nil/empty
          # game state of other player
          moves << TicTacToeNode.new(duped, mark, [i,j])
          # other players mark
          duped[[i,j]]= next_mover_mark
        end
        
      end
    end
    moves
  end

  def switch_mark
    next_mover_mark == :o ? :x : :o
  end

end