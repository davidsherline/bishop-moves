require 'set'

class BishopMoves
  attr_reader :starting_position, :ending_position

  def initialize(starting_position:, ending_position:)
    @starting_position = Position.new(space: starting_position)
    @ending_position = Position.new(space: ending_position)
  end

  def number_of_moves
    return 0 if no_moves?
    return 1 if one_move?
    return 2 if two_moves?
  end

  private

  def no_moves?
    starting_position == ending_position
  end

  def one_move?
    starting_position.direct?(to_position: ending_position)
  end

  def two_moves?
    starting_position.indirect?(to_position: ending_position)
  end
end

class Position
  class OutOfBounds < StandardError; end

  include Comparable

  attr_reader :space, :piece, :board

  def initialize(space:, piece: Bishop.new, board: ChessBoard.new)
    @space = space
    @piece = piece
    @board = board

    raise OutOfBounds.new, "#{space} is out of bounds" unless in_bounds?
  end

  def +(other)
    self.class.new(space: space + other)
  end

  def <=>(other)
    space <=> other.space
  end

  def direct?(to_position:)
    possible_moves.include?(to_position.space)
  end

  def indirect?(to_position:)
    possible_moves.intersect?(to_position.possible_moves)
  end

  protected

  def possible_moves
    @possible_moves ||= piece.directions.collect do |direction|
      moves(from: space, direction: direction)
    end.flatten.compact.to_set
  end

  def on_edge?
    board.edge?(space: space)
  end

  private

  def in_bounds?
    board.in_bounds?(space: space)
  end

  def moves(from:, direction:)
    new_position = self.class.new(space: from + direction)

    valid_moves = []
    until new_position.on_edge?
      valid_moves << new_position.space
      new_position += direction
    end
    valid_moves
  rescue OutOfBounds
    nil
  end
end

class Bishop
  def directions
    [-9, -7, 7, 9]
  end
end

class ChessBoard
  EDGE_SPACES = [1,  2,  3,  4,  5,  6,  7,
                 8,  9,  16, 17, 24, 25, 32,
                 33, 40, 41, 48, 49, 56, 57,
                 58, 59, 60, 61, 62, 63, 64].freeze
  SPACE_RANGE = (1..64).freeze

  def in_bounds?(space:)
    SPACE_RANGE.include?(space)
  end

  def edge?(space:)
    EDGE_SPACES.include?(space)
  end
end
