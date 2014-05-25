require 'lib/label.rb'
require 'lib/plot.rb'
require 'lib/vector_widget.rb'
require 'lib/noise_data.rb'

watch!

class Instrument < Widget
  attr_reader :x, :y, :z, :name

  def initialize(channels, name)
    puts "new #{self.class}     [#{self.object_id}]"

    @x = channels[0]
    @y = channels[1]
    @z = channels[2]

    @name = name

    super
    # @f = create_font("Courier New Bold", 16, true)
  end

  def update_plot_labels
    %w(X Y Z).each_with_index do |axis, n|
      @plot_labels[1 + n].text = "#{axis}=%.8f" % datas[0 + n].value
      @plot_labels[5 + n].text = "#{axis}=%.8f" % datas[3 + n].value
      @plot_labels[9 + n].text = "#{axis}=%.8f" % datas[6 + n].value
    end
  end

  def render_axis
    stroke_weight(1)
    axis_length = @points.last[0] # x for last point

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

    unit_width = @samples_per_unit * @sample_width
    num_vertical = (@width / unit_width.to_f).ceil + 1
    num_vertical.times do |n|
      x = n * unit_width
      line(x, 0, x, @height)
    end
  end
end