require 'hashie/mash'

watch!

class Widget
  include Processing::Proxy
  include Hashie

  attr_accessor :x, :y
  def initialize
    @x = @y = 0
  end

  def move(x,y)
    @x = x
    @y = y
  end

  # def push_matrix
  #   puts "push"
  #   $matrix_stack += 1
  #   $app.push_matrix
  # end

  # def pop_matrix
  #   puts "pop"
  #   $app.pop_matrix
  #   $matrix_stack -=1
  # end

  def push_widget
    push_matrix
    translate(x, y)
  end

  def pop_widget
    pop_matrix
  end

  def local_space
    push_widget
    yield
    pop_widget
  end
end