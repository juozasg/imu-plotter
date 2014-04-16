require 'lib/text.rb'
require 'lib/plot.rb'
require 'lib/noise_data.rb'
watch!

class Plotter
  include Processing::Proxy

  def initialize
    puts "new #{self.class}     [#{self.object_id}]"
    @t = Text.new
    @plots = [Plot.new(100, 20, 30, NoiseData.new(100))]
  end

  def update
    @plots.each {|p| p.update}
  end

  def render
    $app.background(200, 200, 250)
    # @t.text("Hello!!", 200, 200)
    render_plots
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
    translate(20, 20)
  end
end
