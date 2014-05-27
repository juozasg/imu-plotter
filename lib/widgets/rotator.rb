watch!

class Rotator < Widget

  attr_reader :labels, :scale
  def initialize(channel, scale = 120)
    @channels = Mash.new
    @channel = channel
    @width = 140
    @height = 140
    @scale = scale

    @labels = Mash.new
    labels.title = Label.new(channel.name)
    labels.title.move(@width/2, 0)
    labels.title.align_x = CENTER
    labels.title.align_y = CENTER

    labels.value = Label.new("")
    labels.value.align_x = CENTER
    labels.value.align_y = CENTER
    labels.value.move(@width/2, @height)
    labels.value.color = @channel.color
  end

  def update
    labels.value.text = "%+.4f" % @channel.value
  end

  def draw
    local_space do
      labels.values.map(&:draw)
      # move coordinate system so that center of widget is 0,0
      push_matrix
        translate(@width/2, @height/2)

        no_stroke
        fill(255,255,255)
        arc(0,0, scale, scale, 0, PI * 2, PIE)

        rotate(PI * @channel.value)
        stroke_width(2)
        stroke(*@channel.color)
        line(scale/-2,0,scale/2,0) # rotating line

      pop_matrix
    end
  end

end
