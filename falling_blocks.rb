module FallingBlocks

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
  line = FallingBlocks::Piece.new([[0,0],[0,1],[0,2],[0,3]])
  p line.anchor 

  bent = FallingBlocks::Piece.new([[0,1],[0,2],[1,0],[1,1]])
  p bent.anchor
end
