require 'lib/label.rb'
require 'lib/plot.rb'
require 'lib/vector_widget.rb'
require 'lib/widget_3d.rb'
require 'lib/noise_data.rb'
watch!

class Plotter
  include Processing::Proxy

  attr_accessor :datas

  def initialize
    puts "new #{self.class}     [#{self.object_id}]"
    build_plots
    build_plot_labels
    build_widgets
    @f = create_font("Courier New Bold", 16, true)
  end

  def build_plots
    @datas = []
    @plots = []
    9.times do |i|
      noise = NoiseData.new(200 * i)
      c = colors[i]
      plot = Plot.new(c[0], c[1], c[2], noise, (i % 3 == 0)) # every 3rd one has axis
      @datas << noise
      @plots << plot
    end
  end

  def build_plot_labels
    @plot_labels = []
    %w(Acceleration Gyroscope Magnetometer).each_with_index do |label, n|
      offy = 28 + (320 * n)
      @plot_labels << Label.new(28, offy, [0,0,0], label)
      %w(X Y Z).each_with_index do |axis, i|
        offx = 164 + (i * 150)
        @plot_labels << Label.new(28 + offx, offy, colors[n*3 + i], "#{axis}=0.12345678")
      end
    end
  end


  def build_widgets
    @widgets = []
    accel_back = VectorWidget.new({
      :color_x => colors[0], # x data
      :color_y => colors[1], # y data
      :data_x => datas[0],
      :data_y => datas[1],
      :label => "BACK",
      :object_width => 30,
      :object_height => 15
    })
    @widgets << accel_back

    accel_top = VectorWidget.new({
      :color_x => colors[0], # x data
      :color_y => colors[2], # z data
      :data_x => datas[0],
      :data_y => datas[2],
      :label => "TOP",
      :object_width => 30,
      :object_height => 60
    })
    @widgets << accel_top

    accel_side = VectorWidget.new({
      :color_x => colors[2], # z data
      :color_y => colors[1], # y data
      :data_x => datas[2],
      :data_y => datas[1],
      :label => "SIDE",
      :object_width => 60,
      :object_height => 15
    })
    @widgets << accel_side

    accel_3d = Widget3D.new({
      :colors => colors,
      :datas => datas,
      :object_width => 30,
      :object_height => 15,
      :object_length => 60,
    })
    @widgets << accel_3d
  end

  def colors
    # ["f0027f", "7fc97f", "beaed4",
    # "e7298a", "1b9e77", "7570b3",
    # "f781bf", "4daf4a", "984ea3"]
    [[240, 2, 127], # A-X
    [127, 201, 127], # A-Y
    [190, 174, 212], # A-Z
    [231, 41, 138], # G-X
    [27, 158, 119], # G-Y
    [117, 112, 179], # G-Z
    [247, 129, 191], # M-X
    [77, 175, 74], # M-Y
    [152, 78, 163]] # M-Z
  end

  def update
    @plots.each {|p| p.update}
    update_plot_labels
  end

  def update_plot_labels
    %w(X Y Z).each_with_index do |axis, n|
      @plot_labels[1 + n].text = "#{axis}=%.8f" % datas[0 + n].value
      @plot_labels[5 + n].text = "#{axis}=%.8f" % datas[3 + n].value
      @plot_labels[9 + n].text = "#{axis}=%.8f" % datas[6 + n].value
    end
  end

  def render
    $app.background(255, 250, 194)
    stroke_weight(1)
    render_plots
    render_plot_labels
    render_widgets
  end

  def render_widgets
    @widgets.each_with_index do |widget, n|
      push_matrix
      transform_widget(n)
      widget.render
      pop_matrix
    end
  end

  def transform_widget(n)
    offx = (n % 2 == 0) ? 0 : 160
    offy = (n / 2) * (20 + 140)
    translate(700 + offx, 20 + offy)
  end

  def render_plots
    @plots.each_with_index do |plot, n|
      push_matrix
      transform_plot(n)
      plot.render
      pop_matrix
    end
  end

  def transform_plot(n)
    row = (n/3.0).floor
    offy = 20 + (320 * row)
    translate(20, offy)
  end

  def render_plot_labels
    @plot_labels.each(&:draw)
    # %w(Acceleration Gyroscope Magnetometer).each_with_index do |label, n|
    #   push_matrix
    #   offy = (320 * n)
    #   translate(20, offy)
    #   stroke(0,0,0)
    #   text()
    #   pop_matrix
    # end
  end
end
