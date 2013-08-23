#!/usr/bin/env ruby

if ARGV.size < 2
  puts "Usage: #{$0} filename num_kbytes"
  exit
end

filename = ARGV[0]
num_kbytes = ARGV[1].to_i

chars = 'abcdefghjijklmnopqrstuvwxyz01234567890'.chars.to_a

File.open(filename, 'w') do |f|
  num_kbytes.times do
    1023.times do
      f.write( chars.sample )
    end
    f.write( "\n" )
  end
end
