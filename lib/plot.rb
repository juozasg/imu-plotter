watch!
class Plot
  attr_reader :data, :points
  include Processing::Proxy

  def initialize(r, g, b, data_source, draw_axis = true)
    @r, @g, @b = r, g, b
    @ds = data_source
    @draw_axis = draw_axis

    @data = []
    @points = []

    @width = 600
    @height = 60
    @sample_width = 1
    @samples_per_second = nil
  end

  def update
    update_timing
    # pull next point from data source
    @data << @ds.get_value
    max_samples = @width/@sample_width.to_f
    @data = @data.last(max_samples)

    @points = []
    @data.each_with_index do |v, n|
      x = n * @sample_width
      y = (1.0 - v) * @height
      @points << [x,y]
    end
  end

  def update_timing
    unless @last_time
      @last_time = millis
      return
    end
    now = millis
    d = now - @last_time
    @last_time = now

    instant_samples_per_second = 1000.0 / d
  end

  def render
    render_axis if @draw_axis
    render_plot
  end

  def render_plot
    stroke_weight(1.2)
    stroke(@r, @g, @b)
    no_fill

    # graph
    begin_shape
    @points.each do |x, y|
      vertex(x, y)
    end
    end_shape

    # points
    # points.each {|x,y| rect(x-1, y-1, 2, 2)}
  end

  def render_axis
    axis_length = @points.last[0] # x for last point

    stroke_weight(1)

    # bottom stroke
    stroke(140, 140, 140)
    line(0, @height, axis_length, @height)

    # middle stroke
    stroke(160, 160, 160)
    line(0, @height/2, axis_length, @height/2)

    # top stroke
    stroke(140, 140, 140)
    line(0, 0, axis_length, 0)
  end
end