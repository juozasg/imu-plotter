class Reloader
  attr_reader :app_dir, :watched_files

  def initialize(app_dir)
    @app_dir = app_dir
    reset
  end

  def unload_app_files
    unload = $LOADED_FEATURES.select {|path| path.include?(app_dir) && path !~ /jar!/ && path !~ /lib\/ext/}
    unload = unload - [__FILE__] # don't unload self
    unload.each { |f| $LOADED_FEATURES.delete(f) }
  end

  def watchfile(file)
    unless watched_files[file]
      watched_files[file] = File.mtime(file)
    end
  end

  def reset
    @watched_files = {}
  end

  def watched_changed?
    @watched_files.each do |file, mtime|
      return true if mtime < File.mtime(file)
    end
    false
  end
end


module Kernel
  def watch!
    file = caller.first.split(':').first
    $reloader.watchfile(file)
  end
end



puts "loaded lib/ext/reloader.rb"