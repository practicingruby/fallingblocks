require "./falling_blocks"

game = FallingBlocks::Game.new
line_shape = FallingBlocks::Piece.new([[0,0],[0,1],[0,2],[0,3]])
game.piece = line_shape
game.piece_position = [3,3]
game.add_junk([[0,0], [1,0], [2,0], [2,1], [4,0],
              [4,1], [4,2], [5,0], [5,1], [6,0],
              [7,0], [8,0], [8,1], [9,0], [9,1],
              [9,2]])

puts game

puts "\nBECOMES:\n\n"

game.update_junk
puts game
