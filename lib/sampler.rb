watch!

class Sampler
  def initialize
    puts "new #{self.class}     [#{self.object_id}]"
    @channels = []
    @noises = []
    puts "connecting to serial!"
  end

  def add_channel(channel)
    @channels << channel
    @noises << NoiseData.new(200 * @noises.count)
  end

  def sample
    # todo thread this and read real serial
    @channels.each_with_index do |channel, i|
      channel.value = @noises[i].next_value
    end
  end
end