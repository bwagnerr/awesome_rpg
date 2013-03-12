class Player

  @@tileset_id = {
    :up => 12,
    :left => 4,
    :right => 8,
    :down => 0
  }

  def initialize window, character_class
    @class = character_class

    @direction = :down
    @window = window
    @tile_height = 64
    @tile_width = 48
    @x = Random.rand(@window.width/@tile_width) * @tile_width
    @y = Random.rand(@window.height/@tile_height) * @tile_height
    puts @x
    puts @y
    @image = Gosu::Image.load_tiles(@window, "assets/characters/#{character_class}.png", @tile_width, @tile_height, true)
  end

  def draw_character
    @image[facing(@direction)].draw(@x,@y,1)
  end

  def facing direction_key
    @@tileset_id[direction_key]
  end

  def character_class
    @class
  end

  def x
    @x
  end

  def y
    @y
  end

  def move_down player_list
    nextPosition = @y + @tile_height
    if nextPosition < @window.height
      @y = nextPosition if check_collision(player_list)
    @direction = :down
  end

  def move_up player_list
    @afterY = (@y - @tile_height) >= 0 ? @y - @tile_height : @y
    @afterX = @x
    @y = @afterY if check_collision(player_list)
    @direction = :up
  end

  def move_left player_list
    @afterY = @y
    @afterX = (@x - @tile_width) >= 0 ? @x - @tile_width : @x
    @x = @afterX if check_collision(player_list)
    @direction = :left
  end

  def move_right player_list
    @afterY = @y
    @afterX = (@x + @tile_width) < @window.width ? @x + @tile_width : @x
    @x = @afterX if check_collision(player_list)
    @direction = :right
  end

  def check_collision players
    collisions = players.reject do |player| player == self end
    puts "collisions without self: #{collisions.length}"
    collisions = collisions.select do |player|
      puts player.character_class
      puts player.x
      puts player.y
      puts character_class
      puts x
      puts y
      player.x == x and player.y == y
    end
    puts "collisions: #{collisions.length}"
    collisions.empty? ? true : false
  end

end