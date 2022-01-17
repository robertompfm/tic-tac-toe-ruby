# Player class
class Player
  attr_reader :mark
  attr_accessor :name, :score

  def initialize(mark)
    @mark = mark
    @score = 0
  end
end
