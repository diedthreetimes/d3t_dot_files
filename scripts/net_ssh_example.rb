#!/usr/bin/env ruby
require 'pry'
require 'net/ssh'

# A simple test program to work out dealing with threaded ssh connections.
# The idea is to have three threads which continuously print their idea
#  Then, we would like to wait 5 seconds and kill them all

def start id, ip = "localhost", user = "sjfaber", keys = "/Users/sjfaber/.ssh/id_rsa"
   # We may need to do special start for the master
  channel = nil
  channel_thread = Thread.new {
    puts " Inside thread"
    Net::SSH.start(ip, user, :keys => keys) do |ssh|
      puts "Starting #{id}"
      Thread.current[:ssh] = ssh
      channel = ssh.open_channel do |ch|
        puts "About to exec #{id}"

        ch.exec "echo HI there from #{id}; bash" do |ch, success|
          puts "Execing #{id}"
          raise "could not execute command" unless success
          ch.on_data do |c, data|
            $stdout.print data
          end

          ch.on_extended_data do |c, data|
            $stdout.print data
          end

          ch.on_close { puts "disconnecting #{id}" }


          ch.send_data("echo hi2\n")
        end

        ch.send_data("echo hi3\n")

      end

      Thread.current[:channel]=channel
      Thread.current[:channel].send_data("echo hi4\n")

      # This is finally working hooray!! but we should really consider using simple ssh
      #   this will handle timeouts, and keep_alive
      Thread.current[:continue] = true
      ssh.loop(1) do
        Thread.current[:continue] && channel.active?
      end
    end
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
      puts "uh oh"

      x[:continue] = false
    end
  }
end

puts "Joining"
tmp.each do |x|
  x.join
end

puts "Done"
