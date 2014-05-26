watch!

class Vector < Widget
  include Processing::Proxy

  attr_reader :labels
  def initialize(channel, name)
    @channels = Mash.new
    @channel = channel
    @width = 140
    @height = 140

    @labels = Mash.new
    labels.title = Label.new(name)
    labels.title.move(@width/2, 0)
    labels.title.rect_mode = CENTER
    labels.title.align_x = CENTER
    labels.title.align_y = CENTER

    labels.value = Label.new("")
    labels.title.move(@width/2, @height)
  end

  def draw
    local_space do
      labels.values.map(&:draw)
      # move coordinate system so that center of widget is 0,0
      push_matrix
      translate(@width/2, @height/2)

      stroke_width(2)
      stroke(@channel.color)
      line(-60,0,60,0) # rotating line
      pop_matrix
    end
  end

  def render_border
    rect_mode(CENTER)

    no_fill
    stroke_width(1)
    stroke(190, 190, 190)
    rect(0,0,@width,@height)
  end

  def render_label
    rect_mode(CENTER)
    text_align(CENTER, CENTER)

    text_font(@f)
    fill(120,120,120)
    text(@label, 0, 6-(@height/2))

    x = "%.4f" % @data_x.value
    y = "%.4f" % @data_y.value

    rect_mode(CORNER)
    text_align(LEFT, CENTER)

    fill(*@color_x)
    text("#{x}", 4-(@width/2), (@height/2) + 8)

    fill(*@color_y)
    text("#{y}", 8, (@height/2) + 8)
  end

  # represents the IMU object
  def render_object
    stroke(256, 200, 130)
    fill(255, 255, 255)

    rect_mode(CENTER)
    rect(0, 0, @object_width, @object_height)
  end

  def render_vector
    x = (@data_x.value - 0.5) * @width
    y = (@data_y.value - 0.5) * @height
    cx = @color_x
    cy = @color_y
    stroke_width(3)
    stroke(*cx)
    line(0,0,x,0) # horizontal
    stroke(*cy)
    line(x,0,x,y) # vertical

    stroke(0,0,0) # combined
    line(0,0,x,y)
  end

end
