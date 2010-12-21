module FallingBlocks

  class Piece
     SYMBOL = "#"

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

    def paint_shape(shape, position)
      shape.translated_points(position).each do |point|
        paint(point, Piece::SYMBOL)
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
  canvas = FallingBlocks::Canvas.new

  bent_shape = FallingBlocks::Piece.new([[0,1],[0,2],[1,0],[1,1]])

  canvas.paint_shape(bent_shape, [2,3])

  puts canvas
end
