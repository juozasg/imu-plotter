watch!

class Channel
  attr_accessor :value
  attr_reader :color, :name

  def initialize(name, color_index)
    @value = 0.0
    @color = Channel.colors[color_index]
    @name = name
  end

  def self.colors
    [[240, 2, 127], # A-X
    [127, 201, 127], # A-Y
    [90, 74, 250], # A-Z
    [231, 41, 138], # G-X
    [27, 158, 119], # G-Y
    [117, 112, 179], # G-Z
    [247, 129, 191], # M-X
    [77, 175, 74], # M-Y
    [152, 78, 163]] # M-Z
  end
end