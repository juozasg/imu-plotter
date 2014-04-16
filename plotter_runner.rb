require 'pp'

require 'lib/ext/reloader'
app_dir = File.join(File.dirname(__FILE__), 'lib')
$reloader = Reloader.new(app_dir)


class PlotterRunner < Processing::App
  # load_library :controlP5

  java_alias :background_int, :background, [Java::int]
  java_alias :fill_int, :fill, [Java::int]

  def initialize
    super
    @position_frame = true
    @reload = false
    @first_frame_time = nil
  end

  def setup
    size(800,800,P3D)
    smooth(4)
    background(0, 0, 0)
    load!
  end

  def draw
    handle_reloading
    position_frame
    @plotter.update
    @plotter.render
    @first_frame_time ||= millis
  end


  def handle_reloading
    check_watched_files
    reload! if @reload
  end

  def check_watched_files
    if $reloader.watched_changed?
      @reload = true
      $reloader.reset
    end
  end

  def position_frame
    if @position_frame
      # frame.add_window_focus_listener {|e| pp e.getID}
      frame.add_window_listener(java.awt.event.WindowListener.impl {|m,*a| puts m.inspect})
      frame.set_location 100,100
      @position_frame = false
    end
  end

  def reload!
    unload!
    load!
    @reload = false
  rescue
    puts "failed to reload #{$!.inspect}"
    sleep 5
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
      @reload = true
    end
    if key_code == 27 && @first_frame_time # ESC key pressed - print avg fps
      dt = (millis - @first_frame_time) / 1000.0 # elapsed time in second
      puts "avg fps: #{frame_count / dt}"
    end
  end

end

plotter = PlotterRunner.new

