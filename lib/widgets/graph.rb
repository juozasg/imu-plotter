watch!
class Graph < Widget

  def initialize(channel)
    @channel = channel
    @width = 600
    @height = 300
    @data = []

    super()
  end

  def update
    # pull next point from data source
    sample = @channel.value
    @data << sample * @height
    @data.shift if @data.count > @width
    # @data = @data.last(@width)
  end


  def draw
    local_space do
      stroke(*@channel.color)
      no_fill

      # graph
      begin_shape
      @data.each_with_index do |v, x|
        vertex(x, v)
      end
      end_shape

      # points
      # points.each {|x,y| rect(x-1, y-1, 2, 2)}
    end
  end

end