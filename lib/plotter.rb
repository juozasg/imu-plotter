require 'lib/channel.rb'
require 'lib/sampler.rb'
require 'lib/widgets/widget.rb'
require 'lib/widgets/instrument.rb'
watch!

class Plotter
  include Processing::Proxy


  def initialize
    puts "new #{self.class}     [#{self.object_id}]"
    @sampler = Sampler.new
    names = %w(Accel-X Accel-Y Accel-Z Pitch Yaw Roll Mag-X Mag-Y Mag-Z)
    9.times do |i|
      channel = Channel.new(names[i], i)
      @sampler.add_channel(channel)
    end

    # %w(Acceleration Gyroscope Magnetometer)
    @instruments = []
    @instruments << Instrument.new(@sampler.channels[0,3], 'Acceleration', :vector)
    @instruments << Instrument.new(@sampler.channels[3,3], 'Gyroscope', :rotator)
    @instruments << Instrument.new(@sampler.channels[5,3], 'Magnetometer', :vector)
    @instruments[0].move(16, 12)
    @instruments[1].move(16, 345)
    @instruments[2].move(16, 680)
  end


  # def build_widgets
  #   @widgets = []
  #   accel_back = VectorWidget.new({
  #     :color_x => colors[0], # x data
  #     :color_y => colors[1], # y data
  #     :data_x => datas[0],
  #     :data_y => datas[1],
  #     :label => "BACK",
  #     :object_width => 30,
  #     :object_height => 15
  #   })
  #   @widgets << accel_back

  #   accel_top = VectorWidget.new({
  #     :color_x => colors[0], # x data
  #     :color_y => colors[2], # z data
  #     :data_x => datas[0],
  #     :data_y => datas[2],
  #     :label => "TOP",
  #     :object_width => 30,
  #     :object_height => 60
  #   })
  #   @widgets << accel_top

  #   accel_side = VectorWidget.new({
  #     :color_x => colors[2], # z data
  #     :color_y => colors[1], # y data
  #     :data_x => datas[2],
  #     :data_y => datas[1],
  #     :label => "SIDE",
  #     :object_width => 60,
  #     :object_height => 15
  #   })
  #   @widgets << accel_side
  # end

  def update
    @sampler.sample
    @instruments.each {|i| i.update}
  end

  def draw
    $app.background(255, 250, 194)
    @instruments.each do |i|
      i.draw
    end
  end


end
