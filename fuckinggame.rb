require 'gosu'
require './environment'
require './player'

class GameWindow < Gosu::Window

  def initialize
    @stage_width = 1280
    @stage_height = 800
    @last_frame = Gosu::milliseconds
    super @stage_width, @stage_height, false
    @environment = Environment.new self
    @player = Player.new self, :wizard
    @player2 = Player.new self, :monk
    @players = []
    @players << @player
    @players << @player2
    self.caption = "Fucking Game Yo Man"
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    if id == 65362
      @player.move_up @players
    elsif id == 65361
      @player.move_left @players
    elsif id == 65363
      @player.move_right @players
    elsif id == 65364
      @player.move_down @players
    elsif id == 119
      @player2.move_up @players
    elsif id == 97
      @player2.move_left @players
    elsif id == 100
      @player2.move_right @players
    elsif id == 115
      @player2.move_down @players
    end
  end

  def update
    calculate_delta
  end

  def calculate_delta
    @this_frame = Gosu::milliseconds
    @delta = (@this_frame - @last_frame) / 1000.0
    @last_frame = @this_frame
  end
  
  def draw
    @environment.draw_terrain 0,0, @stage_width, @stage_height, :desert
    @player.draw_character
    @player2.draw_character
  end
end

window = GameWindow.new.show