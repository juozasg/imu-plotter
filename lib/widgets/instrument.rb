require 'lib/widgets/axis.rb'
require 'lib/widgets/graph.rb'
require 'lib/widgets/label.rb'

watch!

class Instrument < Widget
  attr_reader :x, :y, :z, :name

  def initialize(channels, name)
    puts "new #{self.class}     [#{self.object_id}]"
    @labels = @graphs = @widgets = []

    @x = channels[0]
    @y = channels[1]
    @z = channels[2]

    @name = name

    # @f = create_font("Courier New Bold", 16, true)
    @axis = Axis.new
    @axis.move(0, 14)

    @graphs << Graph.new(@x)
    @graphs << Graph.new(@y)
    @graphs << Graph.new(@z)
    @graphs.each {|g| g.move(0,14)}

    @title_label = Label.new(name)
    @title_label.move(0, 0)
  end

  def update_plot_labels
    #text = "#{axis}=%.8f" % datas[0 + n].value
  end

  def update
    update_labels
    @graphs.each {|g| g.update}
  end

  def update_labels
  end


  def draw
    local_space do
      @axis.draw
      @title_label.draw
      @graphs.each {|g| g.draw}
      # @labels.each {|l| l.draw}
      # @widgets.each {|w| w.draw}
    end
  end



end