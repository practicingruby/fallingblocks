module FallingBlocks
  class Game
    def initialize
      @junk = Canvas::SIZE.times.map { Array.new(Canvas::SIZE) }
      
      @piece          = nil
      @piece_position = []
    end

    attr_accessor :piece, :piece_position

    def add_junk(points)
      points.each do |x,y|
        @junk[y][x] = true
      end
    end

    # FIXME: Assumes currently piece is going to be transformed
    # into junk without checking to see that it is touching any
    # existing junk
    def update_junk
      convert_piece_to_junk

      @junk.delete_if { |row| row.all? }

      @junk << [] until @junk.length == Canvas::SIZE  
    end

    def convert_piece_to_junk
      add_junk(piece.translated_points(piece_position))
      @piece = nil
      @piece_position = nil
    end

    def to_s
      canvas = Canvas.new

      @junk.each_with_index do |row, y|
        row.each_with_index do |col, x|
          canvas.paint([x,y], "|") if col
        end
      end

      if piece
        canvas.paint_shape(piece, piece_position, "#") 
      end

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

    attr_reader :data

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
