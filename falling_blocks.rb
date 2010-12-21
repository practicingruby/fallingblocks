module FallingBlocks
  class Game
    def initialize
      @junk           = []
      @piece          = nil
      @piece_position = []
    end

    attr_accessor :junk, :piece, :piece_position

    def to_s
      canvas = Canvas.new

      junk.each do |pos|
        canvas.paint(pos, "|")
      end

      canvas.paint_shape(piece, piece_position, "#")

      canvas.to_s
    end
  end

  class Piece
    def initialize(points)
      @points = points
      establish_anchor
    end

    attr_reader :points, :anchor

    # Gets the top-left most point
    def establish_anchor
      @anchor = @points.max_by { |x,y| [y,-x] }
    end

    def translated_points(new_anchor)
      new_x, new_y = new_anchor
      old_x, old_y = anchor

      dx = new_x - old_x
      dy = new_y - old_y
      
      points.map { |x,y| [x+dx, y+dy] }
    end
  end

  class Canvas
    SIZE = 10

    def initialize
      @data = SIZE.times.map { Array.new(SIZE) }
    end

    def paint(point, marker)
      x,y = point
      @data[SIZE-y-1][x] = marker
    end

    def paint_shape(shape, position, marker)
      shape.translated_points(position).each do |point|
        paint(point, marker)
      end
    end

    def to_s
      [separator, body, separator].join("\n")
    end

    def separator
      "="*SIZE
    end

    def body
      @data.map do |row|
        row.map { |e| e || " " }.join
      end.join("\n")
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = FallingBlocks::Game.new
  bent_shape = FallingBlocks::Piece.new([[0,1],[0,2],[1,0],[1,1]])
  game.piece = bent_shape
  game.piece_position = [2,3]
  game.junk += [[0,0], [1,0], [2,0], [2,1], [4,0],
                [4,1], [4,2], [5,0], [5,1], [6,0],
                [7,0], [8,0], [8,1], [9,0], [9,1],
                [9,2]]

  puts game
end
