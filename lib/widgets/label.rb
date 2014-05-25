watch!

class Label < Widget

  attr_accessor :text, :color

  def initialize(text)
    puts "new #{self.class}     [#{self.object_id}]"
    @size = 16
    @color = [0,0,0]
    @text = text
    super()
    @f = create_font("Courier New Bold", @size, true) # true for anti-aliasing
  end

  def draw
    local_space do
      fill(*@color)
      text_font(@f)
      rect_mode(CORNER)
      text_align(LEFT, CENTER)

      $app.text(@text, @x, @y)
    end
  end
end

