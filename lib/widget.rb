watch!

class Widget
  include Processing::Proxy
  attr_accessor :x, :y, :children
  def initialize
    @x = @y = 0
    @children = []
  end

  def add_child(c)
    children << c
  end

  def move(x,y)
    @x = x
    @y = y
  end

  def draw
    push_matrix
    translate(x, y)
    children.each {|c| c.draw}
    render # implementation that calls API calls to draw primitives
    pop_matrix
  end
end