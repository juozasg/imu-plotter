require 'lib/widgets/axis.rb'
require 'lib/widgets/graph.rb'
require 'lib/widgets/label.rb'
require 'lib/widgets/vector.rb'
require 'lib/widgets/rotator.rb'

watch!

class Instrument < Widget
  attr_reader :channels, :name, :graphs, :labels, :widgets

  def initialize(channels, name, mode = :vector)
    puts "new #{self.class}     [#{self.object_id}]"

    @mode = mode
    @channels = Mash.new
    @channels.x = channels[0]
    @channels.y = channels[1]
    @channels.z = channels[2]

    @name = name

    @axis = Axis.new
    @axis.move(0, 14)

    @graphs = Mash.new
    graphs.x = Graph.new(@channels.x)
    graphs.y = Graph.new(@channels.y)
    graphs.z = Graph.new(@channels.z)
    graphs.values.each {|g| g.move(0,14)}


    @labels = Mash.new

    labels.title = Label.new(name)
    labels.title.move(0, 4)

    labels.x = Label.new("x=")
    labels.x.color = @channels.x.color
    labels.x.move(0, 302)

    labels.y = Label.new("y=")
    labels.y.color = @channels.y.color
    labels.y.move(200, 302)

    labels.z = Label.new("z=")
    labels.z.color = @channels.z.color
    labels.z.move(400, 302)

    @widgets = Mash.new

    if @mode == :vector
      build_vector_widgets
    elsif @mode == :rotator
      build_rotator_widgets
    end
  end

  def build_vector_widgets
    widgets.back = Vector.new(@channels.x, @channels.y, "Accel-Back", 20, 8)
    widgets.back.move(700, 14)

    widgets.side = Vector.new(@channels.z, @channels.y, "Accel-Side", 50, 8)
    widgets.side.move(900, 14)

    widgets.top = Vector.new(@channels.x, @channels.z, "Accel-Top", 20, 50)
    widgets.top.move(700, 179)
  end

  def build_rotator_widgets
    widgets.pitch = Rotator.new(@channels.x)
    widgets.pitch.move(700, 14)

    widgets.yaw = Rotator.new(@channels.y)
    widgets.yaw.move(900, 14)

    widgets.roll = Rotator.new(@channels.z)
    widgets.roll.move(700, 179)
  end



  def update
    update_labels
    @graphs.values.map(&:update)
    @widgets.values.map(&:update)
  end

  def update_labels
    labels.x.text = "x=%+.8f" % @channels.x.value
    labels.y.text = "y=%+.8f" % @channels.y.value
    labels.z.text = "z=%+.8f" % @channels.z.value
  end

  def draw
    local_space do
      @axis.draw
      @labels.values.map(&:draw)
      @graphs.values.map(&:draw)
      @widgets.values.map(&:draw)
    end
  end

end