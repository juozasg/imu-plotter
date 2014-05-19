watch!
class Plot
  attr_reader :data, :points, :height
  include Processing::Proxy

  def initialize(r, g, b, data_source, draw_axis = true)
    @r, @g, @b = r, g, b
    @ds = data_source
    @draw_axis = draw_axis

    @data = []
    @points = []

    @width = 600
    @height = 300
    @sample_width = 1
    @samples_per_unit = 120
  end

  def update
    # pull next point from data source
    @data << @ds.next_value
    max_samples = @width/@sample_width.to_f
    @data = @data.last(max_samples)

    @points = []
    @data.each_with_index do |v, n|
      x = n * @sample_width
      y = (1.0 - v) * @height
      @points << [x,y]
    end
  end

  def render
    render_axis if @draw_axis
    render_plot
  end

  def render_plot
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

end