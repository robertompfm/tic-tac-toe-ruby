require_relative 'player'
require_relative 'board'

# Game class
class Game
  @@board = Board.new
  @@player_one = Player.new('O')
  @@player_two = Player.new('X')
  @@players = [@@player_one, @@player_two]
  @@current_player_idx = 0

  def self.start
    @@running = true
    @@current_player_idx = 0
    names
    print new_game_message
    while @@running
      choose_cell
      check_game_over
      switch_player
    end
  end

  def self.names
    puts "\nEnter the name of the first player (O): "
    @@player_one.name = gets.chomp
    puts "\nHello #{@@player_one.name}, you're gonna play with the mark 'O'"
    puts "\nEnter the name of the second player (X): "
    @@player_two.name = gets.chomp
    puts "\nHello #{@@player_two.name}, you're gonna play with the mark 'X'"
  end

  def self.choose_cell
    choosing_cell = true
    player = @@players[@@current_player_idx]
    puts "\n#{player.name}, type the number of the cell you want to mark:"
    while choosing_cell
      cell = gets.chomp
      if cell.downcase == 'quit'
        @@running = false
        return
      end
      if !@@board.valid_cell?(cell)
        puts "\nInvalid input!"\
          "\nYou have to insert a number between 1 and 9."\
          "\nIf you want to quit the game, type 'quit'.\nTry again:"
      elsif !@@board.empty_cell?(cell)
        puts "\nThe selected cell is not empty, try again choosing an empty cell:"
      else
        choosing_cell = false
      end
    end
    @@board.make_move(player, cell)
    puts "\n#{@@board}\n"
  end

  def self.check_game_over
    player = @@players[@@current_player_idx]
    if @@board.victory?(player)
      puts "#{player.name} won!"
      player.score += 1
      new_game
    end
    if @@board.full?
      puts "It's a tie!"
      new_game
    end
  end

  def self.switch_player
    @@current_player_idx = other_player_idx
  end

  def self.other_player_idx
    (@@current_player_idx + 1) % 2
  end

  def self.new_game
    @@board.reset_board
    puts new_game_message
  end

  def self.new_game_message
    "\n=========================\n"\
    "\nNew game beginning...\n"\
    "\n#{@@player_one.name} #{@@player_one.score} x #{@@player_two.score} #{@@player_two.name}"\
    "\n#{@@board}\n"\
  end

  private_class_method :names, :choose_cell, :check_game_over, :switch_player, :other_player_idx, :new_game, :new_game_message
end
