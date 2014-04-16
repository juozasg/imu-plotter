load 'lib/ext/reloader.rb'

puts "print_caller from file:"
print_caller

def pcaller
  puts "print_caller from file:"
  print_caller
end
