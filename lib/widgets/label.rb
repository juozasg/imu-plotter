watch!

class Label < Widget

  attr_accessor :text, :color, :rect_mode, :align_x, :align_y

  def initialize(text)
    @size = 16
    @color = [0,0,0]
    @text = text
    super()
    @f = create_font("Courier New Bold", @size, true) # true for anti-aliasing

    @rect_mode = CORNER
    @align_x = LEFT
    @align_y = CENTER
  end

  def draw
    local_space do
      $app.fill(*@color)
      $app.text_font(@f)
      $app.rect_mode(@rect_mode)
      $app.text_align(@align_x, @align_y)

      $app.text(@text, 0, 0)
    end
  end
end

