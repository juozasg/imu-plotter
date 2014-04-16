watch!

class NoiseData
  def initialize(seed = nil)
    seed ||= rand(1000)
    @offset = seed
    @step = 0.03
  end

  def get_value
    @offset += @step
    $app.noise(@offset)
  end
end