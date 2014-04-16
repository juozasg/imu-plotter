watch!

class Text
  include Processing::Proxy

  def initialize
    puts "new #{self.class}     [#{self.object_id}]"
    @size = 32
    @f = create_font("Courier New Bold", @size, true) # true for anti-aliasing
  end

  def text(string, x, y)
    $app.fill_int(0)
    $app.text_font(@f)
    $app.text(string, x, y)
  end
end

