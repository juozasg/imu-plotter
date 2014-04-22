watch!

class Widget3D
  include Processing::Proxy
  def initialize(opts = {})
    @width = opts[:width] || 140
    @height = opts[:height] || 140

    @object_width = opts[:object_width] || 40
    @object_height = opts[:object_height] || 40
    @object_length = opts[:object_length] || 40

    @colors = opts[:colors]
    @datas = opts[:datas]

    @f = create_font("Courier New Bold", 16, true)
  end

end