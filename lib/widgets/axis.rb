watch!

class Axis < Widget
  def initialize
    @width = 600
    @height = 300
    @unit_width = 50

    super
  end

  def draw
    local_space do
      render_axis
    end
  end

  def render_axis
    stroke_weight(1)

    # bottom stroke
    stroke(180, 180, 180)
    line(0, @height, @width, @height)

    # middle stroke
    stroke(200, 200, 200)
    line(0, @height/2, @width, @height/2)

    # top stroke
    stroke(180, 180, 180)
    line(0, 0, @width, 0)

    # vertical
    stroke(190, 190, 190)

    num_verticals = (@width / @unit_width.to_f).ceil + 1
    num_verticals.times do |n|
      x = n * @unit_width
      line(x, 0, x, @height)
    end
  end
end