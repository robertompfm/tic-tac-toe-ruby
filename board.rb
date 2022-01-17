# Board class
class Board
  CELLS_MAP = {
    '1' => [0, 0],
    '2' => [0, 1],
    '3' => [0, 2],
    '4' => [1, 0],
    '5' => [1, 1],
    '6' => [1, 2],
    '7' => [2, 0],
    '8' => [2, 1],
    '9' => [2, 2],
  }

  def initialize
    @board = initial_board
  end

  def reset_board
    @board = initial_board
  end

  def make_move(player, cell)
    row = CELLS_MAP[cell][0]
    col = CELLS_MAP[cell][1]
    @board[row][col] = player.mark
  end

  def valid_cell?(cell)
    CELLS_MAP.key?(cell)
  end

  def empty_cell?(cell)
    row = CELLS_MAP[cell][0]
    col = CELLS_MAP[cell][1]
    @board[row][col] == cell
  end

  def player_mark?(player, cell)
    row = CELLS_MAP[cell][0]
    col = CELLS_MAP[cell][1]
    @board[row][col] == player.mark
  end

  def victory?(player)
    rows_victory?(player) || cols_victory?(player) || diag_one_victory?(player) || diag_two_victory?(player)
  end

  def full?
    @board.flatten.all? do |cell|
      !CELLS_MAP.key?(cell)
    end
  end

  def to_s
    "\n #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} \n"\
    "---|---|---\n"\
    " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} \n"\
    "---|---|---\n"\
    " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} \n"\
  end

  private

  def rows_victory?(player)
    3.times do |row|
      if row_vicotry?(player, row)
        return true
      end
    end
    false
  end

  def cols_victory?(player)
    3.times do |col|
      if col_victory?(player, col)
        return true
      end
    end
    false
  end

  def row_vicotry?(player, row)
    player.mark == @board[row][0] && @board[row][0] == @board[row][1] && @board[row][1] == @board[row][2]
  end

  def col_victory?(player, col)
    player.mark == @board[0][col] && @board[0][col] == @board[1][col] && @board[1][col] == @board[2][col]
  end

  def diag_one_victory?(player)
    player.mark == @board[0][0] && @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]
  end

  def diag_two_victory?(player)
    player.mark == @board[0][2] && @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]
  end

  def initial_board
    [
      %w[1 2 3],
      %w[4 5 6],
      %w[7 8 9],
    ]
  end
end
