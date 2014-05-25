watch!

class Label < Widget

  attr_accessor :text

  def initialize(color, text)
    puts "new #{self.class}     [#{self.object_id}]"
    @size = 16
    @x, @y, @color, @text = x, y, color, text
    @f = create_font("Courier New Bold", @size, true) # true for anti-aliasing
  end

  def draw
    fill(*@color)
    text_font(@f)
    rect_mode(CORNER)
    text_align(LEFT, CENTER)

    $app.text(@text, @x, @y)
  end
end

