watch!

class NoiseData
  attr_accessor :step, :value
  def initialize(seed = nil)
    seed ||= rand(1000)
    @offset = seed
    @step = 0.003
    @value = 0
  end

  def next_value
    @offset += @step
    @value = $app.noise(@offset)
  end
end