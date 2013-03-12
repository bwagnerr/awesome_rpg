class Environment

  BACKGROUND = Gosu::Color.new(0xFF691F01)

  @@tileset_id = {
    :grass => 0,
    :mud => 14,
    :water => 20,
    :desert => 511
  }

  def initialize window
    @window = window
    @background_tile_size = 16
    @background_image = Gosu::Image.load_tiles(@window, "assets/terrain/tileset.png", @background_tile_size, @background_tile_size, true)
  end

  def draw_terrain start_x, start_y, width, height, terrain_type
    draw_background
    @rows = (width / @background_tile_size + 1).ceil
    @columns = (height / @background_tile_size + 1).ceil
    @rows.times do |row|
      @columns.times do |column|
        @background_image[@@tileset_id[terrain_type]].draw(row*@background_tile_size+start_x, column*@background_tile_size+start_y, 1)
      end
    end
  end

  def draw_background
    @window.draw_quad(
     0, 0, BACKGROUND,
     @window.width, 0, BACKGROUND,
     0, @window.height, BACKGROUND,
     @window.width, @window.height, BACKGROUND,
     0)
  end

end