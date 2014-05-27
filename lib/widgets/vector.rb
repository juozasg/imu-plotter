watch!

class Vector < Widget
  attr_reader :channels, :labels, :width, :height, :scale
  def initialize(chan_x, chan_y, name, object_width, object_height)
    @width = 135
    @height = 135
    @scale = 140

    @object_width = object_width
    @object_height = object_height

    @channels = Mash.new
    channels.x = chan_x
    channels.y = chan_y

    @labels = Mash.new
    labels.title = Label.new(name)
    labels.title.align_x = CENTER
    labels.title.align_y = BOTTOM
    labels.title.move(width/2, 0)

    labels.x = Label.new("x=0.777", 14)
    labels.x.color = channels.x.color
    labels.x.align_x = LEFT
    labels.x.align_y = TOP
    labels.x.move(0, 0)

    labels.y = Label.new("y=0.666", 14)
    labels.y.color = channels.y.color
    labels.y.align_x = RIGHT
    labels.y.align_y = BOTTOM
    labels.y.move(width, height)
  end

  def update
    labels.x.text = "x=%+.5f" % @channels.x.value
    labels.y.text = "z=%+.5f" % @channels.y.value
  end

  def draw
    local_space do
      @labels.values.map &:draw
      no_fill
      stroke(200,200,200)
      rect(0,0,width,height)
      draw_object
      draw_vector
    end
  end

  def draw_vector
    push_matrix
      translate(width/2, height/2)
      vx = channels.x.value * scale
      vy = channels.y.value * scale * -1
      stroke(*channels.x.color)
      line(0,0,vx,0) # horizontal

      stroke(*channels.y.color)
      line(vx,0,vx,vy) # vertical

      stroke(0,0,0) # combined
      line(0,0,vx,vy)
    pop_matrix
  end

  def draw_object
    push_matrix
      translate(width/2, height/2)
      rect_mode(CENTER)
      no_stroke
      fill(255,255,255)
      rect(0, 0, @object_width, @object_height)

      rect_mode(CORNER)
    pop_matrix
  end
end