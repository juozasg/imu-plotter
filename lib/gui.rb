# watch!

# class GUI
#   include Processing::Proxy
#   include_package 'controlP5'

#   def initialize
#     puts "new #{self.class}     [#{self.object_id}]"
#     @cp5 = ControlP5.new($app)
#     @cp5.addButton("colorA")
#      .setValue(99)
#      .setPosition(100,100)
#      .setSize(200,19)

#     # $app.handle("PressMe") { |val| pressme(val)}
#   end

#   def update
#     # TODO: figure this out
#     # puts 1 if @cp5.pressed
#   end

#   def pressme(val)
#     puts "button says: #{val}"
#   end
# end