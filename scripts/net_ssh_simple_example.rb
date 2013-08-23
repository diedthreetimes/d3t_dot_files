#!/usr/bin/env ruby
require 'pry'
require 'net/ssh/simple'

# A simple test program to work out dealing with threaded ssh connections.
# The idea is to have three threads which continuously print their idea
#  Then, we would like to wait 5 seconds and kill them all

def start id, ip = "localhost", user = "sjfaber", keys = "/Users/sjfaber/.ssh/id_rsa"
   # We may need to do special start for the master
  channel_thread = Thread.new {
    puts " Inside thread"
    Net::SSH::Simple.sync do
      puts "Starting #{id}"
      ssh(ip, "echo HI there from #{id}; bash", {:user => user, :keys => keys}) do |e, ch, d|
        case e
        when :start
          Thread.current[:channel]=ch
          ch.send_data("echo hi2\n")
        when :stdout
          $stdout.print d
        when :stderr
          $stdout.print d
          # Use this to get full lines
          # (@buf ||= '') << d
          # while line = @buf.slice!(/(.*)\r?\n/)
          #   puts line #=> "hello stderr"
          # end
          :no_append
        when :exit_code # Triggered by normal return
          puts d
        when :exit_signal
          # If the remote is killed by signal we will get an error
          puts d
          :no_append # triggers not returning the entire output
        when :finish
          puts "disconnecting #{id}"
        end
      end

      puts "Called after exit"
    end
    puts "will have return code available here if we want it"
  }

  channel_thread
end

# Main
tmp = []
4.times do |x|
  tmp.push( start x )
end

sleep(1)

puts "Request more"
tmp.each do |x|
  x[:channel].send_data("echo hi5\n")
end


sleep(2)

puts "Quiting"
tmp.each do |x|
  x[:channel].send_data("exit\n")
  x[:channel].close
end

if !tmp.all?{|x| !x[:channel].active?}
  sleep(3)

  tmp.each{|x|
    if x[:channel].active?
      puts "uh oh what to do"

      # We could try and call close here but it needs to be on the simple session
      #x[:continue] = false
    end
  }
end

puts "Joining"
tmp.each do |x|
  x.join
end

puts "Done"
