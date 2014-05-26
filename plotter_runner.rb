require 'pp'

$: << '.'
require 'lib/ext/reloader'
app_dir = File.join(File.dirname(__FILE__), 'lib')
$reloader = Reloader.new(app_dir)


class PlotterRunner < Processing::App
  java_alias :background_int, :background, [Java::int]
  java_alias :fill_int, :fill, [Java::int]

  def initialize
    super
    @position_frame = true
    @loaded = false
    @first_frame_time = nil
    @error = nil
  end

  def print_error
    puts "--------------"
    puts $!.inspect
    puts $!.backtrace.join("\n")
  end

  def setup
    size(1200,980,P3D)
    # no_smooth
    smooth(4)
    background(0, 0, 0)
    @font = create_font("Free Monospaced", 20, true) # true for anti-aliasing
  end

  def draw
    clear

    position_frame
    handle_loading
    loaded? ? draw_app : draw_error
  rescue
    @error = $!
    print_error
    @loaded = false
    begin_load_cooldown
  end

  def draw_app
    @plotter.update
    @plotter.draw
    @first_frame_time ||= millis
  end

  def draw_error
    text = "Mystery error"
    if @error
      text = "error\n-----\n" + @error.inspect + "\n" + @error.backtrace.join("\n")
      text += "\n\n" + (@load_cooldown - millis()).to_s if @load_cooldown
    end
    restore_matrix
    fill(200,200,200)
    text_font(@font)
    text_align(LEFT, LEFT)
    text(text, 30, 30)
  end


  def restore_matrix
    # while $matrix_stack > 0
    #   $app.pop_matrix
    #   $matrix_stack -= 1
    # end
    m = [1.0, 0.0, 0.0, -600.0, 0.0, 1.0, 0.0, -490.0, 0.0, 0.0, 1.0, -848.7049, 0.0, 0.0, 0.0, 1.0]
    reset_matrix
    apply_matrix(*m)
  end


  def handle_loading
    check_watched_files
    reload! if !loaded? && load_cooldown_expired?
  end

  def check_watched_files
    if $reloader.watched_changed?
      @loaded = false
      $reloader.reset
    end
  end

  def position_frame
    if @position_frame
      frame.set_location 100,20
      @position_frame = false
    end
  end

  def loaded?
    @loaded
  end

  def begin_load_cooldown
    @load_cooldown = 10 * 1000 + millis()
  end

  def load_cooldown_expired?
    return true unless @load_cooldown
    @load_cooldown < millis()
  end

  def reload!
    unload!
    load!
    @loaded = true
    @load_cooldown = false
  rescue
    @loaded = false
    @error = $!
    print_error
    begin_load_cooldown
  end

  def unload!
    $reloader.unload_app_files
    $reloader.reset
  end

  def load!
    require 'lib/plotter.rb'
    @plotter = Plotter.new
  end

  def key_pressed
    # key_code = 116 is F5
    if key == 'r'
      @loaded = false
      @load_cooldown = nil
    end
    if key_code == 27 && @first_frame_time # ESC key pressed - print avg fps
      dt = (millis - @first_frame_time) / 1000.0 # elapsed time in second
      puts "avg fps: #{frame_count / dt}"
    end
  end

end

plotter = PlotterRunner.new

