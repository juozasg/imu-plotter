require 'hashie/mash'

require 'lib/widgets/axis.rb'
require 'lib/widgets/graph.rb'
require 'lib/widgets/label.rb'

watch!

class Instrument < Widget
  include Hashie
  attr_reader :channels, :name, :graphs, :labels

  def initialize(channels, name)
    puts "new #{self.class}     [#{self.object_id}]"

    @channels = Mash.new
    @channels.x = channels[0]
    @channels.y = channels[1]
    @channels.z = channels[2]

    pp channels

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
    labels.title.move(0, 0)

    labels.x = Label.new("x=")
    labels.x.color = @channels.x.color
    labels.x.move(0, 320)

    labels.y = Label.new("y=")
    labels.y.color = @channels.y.color
    labels.y.move(200, 320)

    labels.z = Label.new("z=")
    labels.z.color = @channels.z.color
    labels.z.move(400, 320)
  end



  def update
    update_labels
    @graphs.values.map(&:update)
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
    end
  end



end